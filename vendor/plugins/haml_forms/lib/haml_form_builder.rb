
# A form builder that uses haml to produce tableless, lined-up forms.
#
class HamlFormBuilder < ActionView::Helpers::FormBuilder
  
  # automatically wrap all the standard formbuilder helpers
   (field_helpers - %w(label radio_button hidden_field text_area)).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {}, &block)
        format_with_label(field, options.merge(:field_type => "#{selector}"), super(field, purge_custom_tags(options)), &block)
      end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end
  
  def text_area(field, options = {}, &block)
    format_with_label(field, options.merge(:field_type => "text_area", :preserve => true), super(field, purge_custom_tags(options)), &block)
  end
  
  # wrap the date_select helper
  def date_select(field, options={}, &block)
    format_with_label(field, options.merge(:field_type => "date"), super(field, purge_custom_tags(options)), &block)
  end
  
  # create a radio group helper that works very similarly to the select helper
  def radio_group(field, choices, options={}, &block)  
    
    # handle special cases
    if choices == :boolean
      choices = [["True", "true"], ["False", "false"]]
    elsif choices == :yes_no
      choices = [["Yes", "yes"], ["No", "no"]]
    elsif choices.class != Array
      choices = []
    end
    
    # cycle through choices and build up html
    choices_html = @template.capture_haml do      
      # wrap each radio-option in a label (so we can select it easier)
      choices.each do |key, value| 
        @template.haml_tag "label", :class => "radio-option" do
          @template.puts radio_button(field, value)
          @template.puts key
        end
      end
    end    
    
    format_with_label(field, options.merge(:field_type => "radio-group"), choices_html, &block)
  end

  # wrap the select helper
  def select(field, choices, options={}, &block)
    html_options = options.delete(:html) || {}
    format_with_label(field, options.merge(:field_type => "select"), super(field, choices, options, html_options), &block)
  end
  
  # create a submit helper
  def submit(value = "Submit", options = {})
    @template.puts @template.submit_tag(value, options)
  end

  # create a image_submit helper
  def image_submit(img_path, options = {})
    @template.puts @template.image_submit_tag(img_path, options)
  end
  
  # create an error messages helper
  def error_messages(object_name = nil)
    @template.error_messages_for object_name || @object_name
  end
  
  private
  
  # format a helper by generating the haml to wrap it in a field_tag and include a label
  def format_with_label(field, options, tag_output, &block)
    # see if we have an error on the field
    errors_on = object.send(:errors).send(:on, field)
    has_error = true unless errors_on.blank?
    
    # set field options
    options[:field] ||= {}
    options[:field].merge!(:has_error => has_error, :field_type => options[:field_type])
    
    if options[:preserve]
      tag_output = @template.preserve(tag_output)
    end
  
    # generate haml
    @template.capture do
      @template.field_tag(options[:field]) do
        @template.puts @template.label(@object_name, field, options[:label], :separator => options[:separator] || default_separator)
        @template.puts tag_output
        @template.puts @template.capture_haml(&block) if block_given?
        @template.puts @template.validation_tag(@object, field)
      end
    end
  end
  
  def default_separator
    ": "
  end
  
  # Removes tags such as :html, :label so they dont get rendered on the final html
  def purge_custom_tags(options)
    options.reject{ |key,value| [:label, :html, :field, :field_type, :separator].include?(key.to_sym) }
  end
end

# Create a form_for block using HamlFormBuilder
def haml_form_for(record_or_name_or_array, *args, &proc)  
  options = args.extract_options!
  args << options.merge(:builder => HamlFormBuilder)
  form_for(record_or_name_or_array, *args, &proc)
end

# Create a fields_for block using HamlFormBuilder
def haml_fields_for(object_or_object_name, *args, &block)
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
  
  yield HamlFormBuilder.new(object_name, object, self, options, block)
end