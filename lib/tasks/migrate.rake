require 'rubygems'
require 'rake'

class Rake::Task
  def overwrite(&block)
    @actions.clear
    enhance(&block)
  end
end

# Overwrite migrate task
Rake::Task["db:migrate"].overwrite do
  puts "Running Auto Migration and DB Seed..."
  
  Rake::Task["db:auto:migrate"].invoke
  Rake::Task["db:seed"].invoke
end
# 
# task :wtf => :environment do
#   puts Rails.env
# end