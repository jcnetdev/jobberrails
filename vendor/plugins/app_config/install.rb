# 
# Insert line: [require 'plugins/app_config/lib/configuration']
# before Initializer.run in conf/environment.rb file
# 

file = File.join(File.dirname(__FILE__), '../../../config/environment.rb')
unless File.exists?(file)
    STDERR.puts("ERROR: Could not locate config/environment.rb file.") 
    exit(1)
end

# Tip from http://pleac.sourceforge.net/pleac_ruby/fileaccess.html
# 'Modifying a File in Place Without a Temporary File'
output= ""
inserted = false
LINE_TO_INSERT = %Q{require 'plugins/app_config/lib/configuration'}
File.open(file, 'r+') do |f|   # open file for update
    # read into array of lines and iterate through lines
    f.readlines.each do |line| 
puts line
        unless inserted 
            if line.gsub(/#.*/, '').include?(LINE_TO_INSERT)
                inserted = true
            elsif line.gsub(/#.*/, '').include?('Rails::Initializer.run')
                output << LINE_TO_INSERT
                output << "\n"
                inserted = true
            end
        end     
        output << line
    end
    f.pos = 0                     # back to start
    f.print output                # write out modified lines
    f.truncate(f.pos)             # truncate to new length
end   

unless inserted
    STDERR.puts <<END 
ERROR: Could not update config/environment.rb
To finish installation try to add the following line to 
config/environment.rb manually: 
\t#{LINE_TO_INSERT}
NOTE: line must be inserted before Rails::Initializer.run()
END
    exit(1)
end