module FormFu
  module Helpers
    # Create a form_for block using FormFuBuilder
    def formfu_for(*args, &block)  
      raise ArgumentError, "Missing block" unless block_given?
      
      options = args.extract_options!
      args << options.merge(:builder => FormFu::FormBuilder)
      form_for(*args, &block)
      
    end
    
    # also work with the more semantic name (build_form_for)
    alias :build_form_for :formfu_for


    # Create a form_for block using FormFuBuilder
    def remote_formfu_for(*args, &block)  
      raise ArgumentError, "Missing block" unless block_given?
      
      options = args.extract_options!
      args << options.merge(:builder => FormFu::FormBuilder)
      remote_form_for(*args, &block)
    end
    
    # also work with the more semantic name (build_form_for)
    alias :build_remote_form_for :remote_formfu_for

    
    # Create a fields_for block using FormFuBuilder
    def formfu_fields_for(object_or_object_name, *args, &block)
      raise ArgumentError, "Missing block" unless block_given?
      options = args.extract_options!

      if object_or_object_name.class == Symbol
        # if object_or_object_name is a symbol, use the object from args
        object_name = object_or_object_name
        object  = args.first
      else
        # otherwise retrieve the object_name from ActiveRecord helper
        object = object_or_object_name
        object_name = ActionController::RecordIdentifier.singular_class_name(object)
      end

      yield FormFu::FormBuilder.new(object_name, object, self, options, block)
    end 
    
    # also work with the more semantic name (build_fields_for)
    alias :build_fields_for :formfu_fields_for
    
    # wrap content with a fieldset tag with a legend
    def fieldset_tag(legend_name, options = {}, &block)
      if block_given?
        universal_concat(content_tag(:fieldset, options) do
          (legend_name ? content_tag(:legend, legend_name) : "")+
          universal_capture(&block)
        end)
      else
        return content_tag(:fieldset, options) do
          content_tag :legend, legend_name
        end
      end
    end

    #generate a field div with label
    def field_tag(options_or_label = {}, content = nil, &block)
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
      
      if block_given?
        universal_concat(content_tag(:div, options) do
          (label.blank? ? "" : content_tag(:label, label.strip)) +
          universal_capture(&block)
        end)
      else
        content_tag(:div, options) do
          (label.blank? ? "" : content_tag(:label, label.strip))+content.to_s
        end
      end
    end
    
    # show validation error is applicable
    def validation_tag(model, attribute, options = {})
      return if model.blank? or model.errors.blank?    
      unless model.errors[attribute].blank?
        # generate error markup
        content_tag :span, :class => "error-message" do
          [model.errors[attribute]].flatten.join(options[:separator] || ", ").to_s
        end
      end
    end
    
    def universal_capture(&block)
      if respond_to?(:is_haml?) and is_haml?
        capture_haml(&block)
      else
        capture(&block)
      end
    end

    def universal_concat(html)
      if haml?
        haml_concat(html)
      else
        concat(html)
      end
    end
    
  end
end