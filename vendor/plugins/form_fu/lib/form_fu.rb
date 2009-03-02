require "form_fu/form_builder"
require "form_fu/helpers"
ActionView::Base.send :include, FormFu::Helpers

# Override the error proc to use a span instead of a div
module ActionView
  class Base #:nodoc:
    @@field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }
    cattr_accessor :field_error_proc
  end 
end

# Add a to_select method to our ActiveRecord models
module ActiveRecord
  class Base
    #find all items matching _condition_, and return an array of [value,key], useful for using with select
    def self.to_select(method='to_s', conditions=nil)
      find(:all, :conditions => conditions).collect{|record| [record.send(method), record.id]}
    end
  end
end