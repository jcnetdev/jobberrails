require 'fileutils'
require 'cgi'
require 'net/https'
require 'yaml'
require 'highline/import'
load 'deploy'

# The svn repository is used to export the code into the temporary directory before 
# uploading code into the Morph control panel. Currently only svn is supported, 
# but you could change it to fit your need by changing the get_code task
set :repository, "." # Set here your repository! Example: 'https://www.myrepo.com/myapp/trunk'
set :repo_line_number, __LINE__ - 1 # Needed to report missing repository later on

# The version name to set in the control panel. Defautls to date and time, but can be altered by passing it
# on the command line as -s version_name='The Version Name'
set :version_name, Time.now.utc.strftime('%Y-%m-%d %H:%M:%S')

# If you want to use a different scm or use a different export method, you can chane it here
# Please note that the export to directory is removed before the checkout starts. If
# You want it to work differently, change the code in the get_code task 
set :deploy_via, :export
set :scm, :git

# MORPH SETTINGS, please do not change
set :morph_host, "panel.mor.ph"
set :morph_port, 443
set :morph_tmp_dir, 'morph_tmp'
set :mex_key, "87fbf9317764fd9821c7a39d26379a60659edd41"
set :mv_cmd, PLATFORM.include?('mswin') ? 'ren' : 'mv'
set :morph_tmp_dir, 'morph_tmp'
set :release_path, morph_tmp_dir # needed in order to generate the correct scm command 
set :get_code_using, :get_code
set :req_retries, 3


namespace :morph do

  abort('*** ERROR: You need a MeX key!') if !exists?(:mex_key) || mex_key.nil?

  # This is the entry point task. It gets the new code, then upload it into S3
  # to a special folder used later for deployment. Finally it mark the version 
  # Uploaded to be deployed
  task :deploy do
    transaction do
      update_code

      send_request(true, 'Post', morph_host, morph_port, '/api/deploy/deploy', {}, nil, "*** ERROR: Could not deploy the application!")
      say("Deploy Done.")        
    end
  end

  # Specialized command to deploy from a packaged gem
  task :deploy_from_gem do
    set :get_code_using, :get_code_from_gem 
    deploy
  end

  # This task calls the get_code helper, then upload the code into S3 
  task :update_code do
    transaction do
      s3_obj_name = upload_code_to_s3
      say("Creating new appspace version...")
      
      #create a version in CP
      req_flds = { 'morph-version-name' => version_name, 'morph-version-s3-object' => s3_obj_name }
      send_request(true, 'Post', morph_host, morph_port, '/versions/create2', req_flds, nil, "*** ERROR: Could not create a new version!") 
      say("Code Upload Done.")  
    end
  end

  # A task that create a temp dir, export the code ouf ot svn and tar
  # the code preparing it for upload.
  # If you are not using svn, or using a different source control tool
  # you can customize this file to work with it. The requirement is that
  # It will export the whole structure into the temp directory as set in
  # morph_tmp_dir.
  # 
  # You can choose to release a different version than head by setting the 
  # Environment variable 'REL_VER' to the version to use.
  task :get_code do
    on_rollback do      
      remove_files([morph_tmp_dir, 'code_update.tar.gz'])
    end
      
    # Make sure we have a repo to work from!
    abort("***ERROR: Must specify the repository to check out from! See line #{repo_line_number} in #{__FILE__}.") if !repository

    transaction do
      # Clean up previous deploys   
      remove_files([morph_tmp_dir, 'code_update.tar.gz'])

      #get latest code from from the repository 
      say("Downloading the code from the repository...")
      system(strategy.send(:command))
      abort('*** ERROR: Export from repository failed! Please check the repository setting at the start of the file') if $?.to_i != 0

      # Verify that we have the expected rails structure 
      ['/app', '/public', '/config/environment.rb', '/lib'].each do |e| 
        abort "*** ERROR: Rails directories are missing. Please make sure your set :repository is correct!" if !File.exist?("#{morph_tmp_dir}#{e}")
      end

      #create archive
      system("tar -C #{morph_tmp_dir} -czf code_update.tar.gz --exclude='./.*' .")
      abort('*** ERROR: Failed to tar the file for upload.') if $?.to_i != 0
      
      # Verify that we have the expected rails structure in the archive
      flist = `tar tzf code_update.tar.gz`
      all_in = flist.include?('lib/') && flist.include?('app/') && flist.include?('config/environment.rb')
      abort "***ERROR: code archive is missing the rails directories. Please check your checkout and tar" if !all_in

      remove_files([morph_tmp_dir])
    end
  end

  # Get the code from a packaged gem. Name comes from a setting passed to the command
  # using the -s form
  task :get_code_from_gem do
    # Make sure we have the gem defined and that we have the gem file
    if !exists?(:gem_file) || gem_file.nil?
      abort("***ERROR: The gem file must be provided on the command line using -s.\n          For example: cap -f morph_deploy.rb -s gem_file=/home/morph/my_app.gem morph:deploy_from_gem") 
    end

    abort("***ERROR: gem file not found! Please check the file location and try again") if !File.exists?(gem_file)

    # Remove older file
    remove_files(["code_update.tar.gz"])

    # Extract the data.tar.gz code from the gem
    system("tar xf #{gem_file} data.tar.gz")
    abort("***ERROR: Couldn't find the data.tar.gz file in the gem file provided!") if !File.exists?('data.tar.gz')

    # rename it to upload_code.tar.gz
    system("#{mv_cmd} data.tar.gz code_update.tar.gz")
  end

  # A task to get the S3 connection info and upload code_update.tar.gz
  # Assumes another task prepared the tar.gz file
  task :upload_code_to_s3 do
      
    self.send get_code_using

    abort "*** ERROR: Could not find archive to upload." unless File.exist?('code_update.tar.gz')

    s3_data = ''
    say('Getting upload information')
    send_request(true, 'Get', morph_host, morph_port, '/api/s3/connection_data', {}, nil, "*** ERROR: Could not get the S3 connection data!") do |req, res|
      s3_data = YAML.load(res.body)
    end

    if !s3_data.empty?
      say('Uploading code to S3...')
      File.open('code_update.tar.gz', 'rb') do |up_file|
        send_request(false, 'Put', s3_data[:host], morph_port, s3_data[:path], s3_data[:header], up_file, "*** ERROR: Could not upload the code!") 
      end
    end

    s3_data[:obj_name]
  end

  # Helper to add the mex auth fields to the requests
  def add_mex_fields(req)
    req['morph-user'] = morph_user
    req['morph-pass'] = morph_pass
    req['morph-app']  =  mex_key
  end

  # Helper to generate REST requests, handle authentication and errors
  def send_request(is_mex, req_type, host, port, url, fields_hash, up_file, error_msg)
    tries_done = 0
    res = ''
    while res != :ok
      if is_mex
        say("*** Getting info for Morph authentication ***") if !exists?(:morph_user) || morph_user.nil? || !exists?(:morph_pass) || morph_pass.nil?
        set(:morph_user, ask("Morph user: ")) if !exists?(:morph_user) || morph_user.nil?
        set(:morph_pass, ask("Password:  ") { |q| q.echo = false }) if !exists?(:morph_pass) || morph_pass.nil?
      end

      conn_start(host, port) do |http|
        request = Module.module_eval("Net::HTTP::#{req_type}").new(url)
        add_mex_fields(request) if is_mex
        fields_hash.each_pair{|n,v| request[n] = v} # Add user defined header fields
        # If a file is passed we upload it. 
        if up_file
          request.content_length = up_file.lstat.size   
          request.body_stream = up_file  # For uploads using streaming
        else
          request.content_length = 0
        end

        begin
          response = http.request(request)
        rescue Exception => ex
          response = ex.to_s
        end

        # Handle auth errors and other errors!
        res = verify_response(request, response, is_mex)
        if res == :ok
          yield(request, response) if block_given?
        elsif res != :auth_fail # On auth_fail we just loop around
          tries_done += 1
          abort(error_msg) if tries_done > req_retries
        end
      end
    end
  end
  
  # Helper to create a connection with all the needed setting
  # And yeals to the block
  def conn_start host = morph_host, port = morph_port
    con = Net::HTTP.new(host, port)
    con.use_ssl = true
    # If you have cert files to use, change this to OpenSSL::SSL::VERIFY_PEER
    # And set the ca_cert of the connection
    con.verify_mode = OpenSSL::SSL::VERIFY_NONE
    con.start
    if block_given?
      begin
        return yield(con)
      ensure
        con.finish
      end
    end
    con
  end

  # Helper to verify if a response is valid. Also handles authentication failures into MeX
  def verify_response(request, response, is_mex)
    res = :ok
    if !response.is_a?(Net::HTTPOK)
      if response.is_a?(Net::HTTPForbidden) && is_mex
        say("Authentication failed! Please try again.")
        set :morph_user, nil
        set :morph_pass, nil
        res = :auth_fail
      else
        if response.is_a?(String)
          say("*** ERROR: connection failure: #{response}")
        else
          output_request_param(request, response)
        end
        res = :failure
      end
    end  
    return res
  end

  # Helper to output the results of REST calls to our servers or S3
  def output_request_param(request, response)
    puts "\n========== ERROR TRACE =========="
    puts "+++++++ REQUEST HEADERS +++++++++"
    request.each {|e,r| puts "#{e}: #{r}"}
    puts "+++++++ RESPONSE HEADERS +++++++++"
    response.each {|e,r| puts "#{e}: #{r}"}
    puts "+++++++ RESPONSE BODY +++++++++"
    puts response.body
    puts "+++++++ RESPONSE TYPE +++++++++"
    puts "#{response.class} (#{response.code})"
    puts "========= END OF TRACE ==========\n"
  end

  def remove_files(lists)
    FileUtils.cd(FileUtils.pwd)
    FileUtils.rm_r(lists, :force => true) rescue ''
  end  

end
