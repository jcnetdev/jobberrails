# Load the plugin testing framework
$:.unshift("#{File.dirname(__FILE__)}/../../plugin_test_helper/lib")
require 'rubygems'
require 'plugin_test_helper'

# Run the migrations
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")
