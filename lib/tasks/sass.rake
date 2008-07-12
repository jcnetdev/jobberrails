require 'haml'
require 'sass'

namespace :sass do
  
  desc 'Clean and Build Sass Templates'
  task :rebuild => [:clean, :build]
  
  desc 'Find all Sass Templates and delete their related css files'
  task :clean do
    puts "Cleaning SASS Generated Files..."
    find_sass.each do |sass_path|
      css_path = css_path_for(sass_path)

      # delete css file if it exists
      if File.exists?(css_path)        
        File.delete(css_path) 
        puts "Deleted "+path_clean(css_path)
      end
    end
    puts "\n"
    
    puts "Clearing SASS Generated Directories..."
    find_sass_directories.each do |sass_dir_path|
      css_dir_path = css_path_for(sass_dir_path)
      if File.exists?(css_dir_path)
        FileUtils.remove_dir(css_dir_path) 
        puts "Deleted "+path_clean(css_dir_path)
      end
    end
    
    puts "\n"
  end
  
  # Rebuild sass files without needing rails  
  desc 'Find all Sass Templates and render their related css file'
  task :build do
    puts "Building CSS Directories..."
    find_sass_directories.each do |sass_dir_path|
      css_dir_path = css_path_for(sass_dir_path)
      puts "Creating Directory "+path_clean(css_dir_path)+" from "+path_clean(sass_dir_path)
      FileUtils.mkdir_p(css_dir_path)
    end
    puts "\n"
    
    puts "Building CSS Generated Files from SASS..."
    find_sass.each do |sass_path|
      puts "Generating "+path_clean(css_path_for(sass_path))+" from "+path_clean(sass_path)
      render_sass(sass_path)
    end
    puts "\n"
  end

  # recursively search sass directory for sass files
  def find_sass
    Dir["#{RAILS_ROOT}/public/stylesheets/sass/**/*.sass"]
  end
  
  def find_sass_directories
    Dir["#{RAILS_ROOT}/public/stylesheets/sass/**/*/"]
  end
  
  # Find the css path for a related sass file
  def css_path_for(sass_path)
    sass_path \
      .gsub("#{RAILS_ROOT}/public/stylesheets/sass/","#{RAILS_ROOT}/public/stylesheets/") \
      .gsub(".sass",".css")
  end
  
  # Removes RAILS_ROOT from a css path so we can display it
  def path_clean(file_path)
    file_path.gsub("#{RAILS_ROOT}/public/stylesheets/", "")
  end
  
  # Writing Sass
  def render_sass(sass_path)
    # template = File.load(sass_path)
    import_statement = "@import "+path_clean(sass_path).gsub("sass/", "").gsub(".sass", "")
    sass_engine = Sass::Engine.new(import_statement, {:load_paths => ["#{RAILS_ROOT}/public/stylesheets/sass"], :style => :compact})
    
    # write output
    File.open(css_path_for(sass_path), "w") do |f|
      f.puts sass_engine.render
    end
  end
  
end