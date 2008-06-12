namespace :db do
  namespace :mysql do
    desc "Dump schema and data to an SQL file (/db/backup_YYYY_MM_DD.sql)"
    task :backup => :environment do
      current_date = Time.now.strftime("%Y_%m_%d")
      archive = "#{RAILS_ROOT}/db/backup_#{current_date}.sql"
      database, user, password = retrieve_db_info
    
      cmd = "/usr/bin/env mysqldump --opt --skip-add-locks -u#{user} "
      puts cmd + "... [password filtered]"
      cmd += " -p'#{password}' " unless password.nil?
      cmd += " #{database} > #{archive}"
      result = system(cmd)
    end
  
    desc "Load schema and data from an SQL file (/db/restore.sql)"
    task :restore => :environment do
      archive = "#{RAILS_ROOT}/db/restore.sql"
      database, user, password = retrieve_db_info
    
      cmd = "/usr/bin/env mysql -u #{user} #{database} < #{archive}"
      puts cmd + "... [password filtered]"
      cmd += " -p'#{password}'"
      result = system(cmd)
    end
  
    desc "Create database (using database.yml config)"
    task :create => :environment do
      database, user, password = retrieve_db_info
    
      sql = "CREATE DATABASE #{database};"
      sql += "GRANT ALL PRIVILEGES ON #{database}.* TO #{user}@localhost IDENTIFIED BY '#{password}';"
      mysql_execute(user, password, sql)
    end

    desc "Destroy database (using database.yml config)"
    task :destroy => :environment do
      database, user, password = retrieve_db_info
      sql = "DROP DATABASE #{database};"
      mysql_execute(user, password, sql)
    end
  end
end

  private
  def retrieve_db_info
    result = File.read "#{RAILS_ROOT}/config/database.yml"
    result.strip!
    config_file = YAML::load(ERB.new(result).result)
    return [
      config_file[RAILS_ENV]['database'],
      config_file[RAILS_ENV]['username'],
      config_file[RAILS_ENV]['password']
    ]
  end
  
  def mysql_execute(username, password, sql)
    system("/usr/bin/env mysql -u #{username} -p'#{password}' --execute=\"#{sql}\"")
  end
