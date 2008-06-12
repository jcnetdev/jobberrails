module ApplicationHelper  
  
  #generate a fieldset tag, including a _legend_ and the block content
  def fieldset_tag(legend_name, options = {}, &block)
    haml_tag "fieldset", options do
      haml_tag("legend"){ puts legend_name }
      yield
    end
  end
  
  #generate a field div with label
  def field_tag(options_or_label = {}, &block)
    
    label, options =  "", {}
    if options_or_label.class == String
      label = options_or_label
      options[:class] = "field"
    else
      options = options_or_label
      # grab the error indicator out of the options
      has_error = options.delete(:has_error) || false
    
      # grab the field_type out of the options
      field_type = options.delete(:field_type) || nil
      
      # append field as css class for div options
      options[:class] = "field #{field_type} #{options[:class]} #{'withErrors' if has_error}"
    end
    
    # generate haml markup
    haml_tag "div", options do
      unless label.blank?
        haml_tag :label, label.strip
      end
      puts capture_haml(&block) if block_given?
    end
  end
  
  # Show a label tag
  def label_tag(content, options = {})
    content_tag(:label, content, options)
  end
  
  # show validation error is applicable
  def validation_tag(model, attribute)
    return if model.blank? or model.errors.blank?    
    unless model.errors[attribute].blank?
      # generate haml markup for error
      haml_tag "span", :class => "error-message" do
        puts "#{[model.errors[attribute]].flatten.join(",<br /> ")}"
      end
    end
  end
  
end

# Override the error proc to use a span instead of a div
module ActionView
  class Base #:nodoc:
    @@field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }
    cattr_accessor :field_error_proc
  end
end

module ActiveRecord
  class Base
    #find all items matching _condition_, and return an array of [value,key], useful for using with select
    def self.to_select(method='to_s', conditions=nil)
      find(:all, :conditions => conditions).collect{|record| [record.send(method), record.id]}
    end
  end
end