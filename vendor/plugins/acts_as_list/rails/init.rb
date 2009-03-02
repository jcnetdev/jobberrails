require 'acts_as_list'
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::List }
