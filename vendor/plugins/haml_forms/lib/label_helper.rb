module ActionView #:nodoc:
  module Helpers #:nodoc:
  
    module FormHelper
      # Returns a label tag tailored for labelling an input field for a specified attribute (identified by +method+) on an object
      # assigned to the template (identified by +object+). The text of label will default to the attribute name unless you specify
      # it explicitly. Additional options on the label tag can be passed as a hash with +options+. These options will be tagged
      # onto the html as an HTML element attribute as in the example shown.
      #
      # ==== Examples
      #   label(:post, :title)
      #   #=> <label for="post_title">Title</label>
      #
      #   label(:post, :title, "A short title")
      #   #=> <label for="post_title">A short title</label>
      #
      #   label(:post, :title, "A short title", :class => "title_label")
      #   #=> <label for="post_title" class="title_label">A short title</label>
      #
      def label(object_name, method, text = nil, options = {})
        InstanceTag.new(object_name, method, self, nil, options.delete(:object)).to_label_tag(text, options)
      end
    end
    
    class FormBuilder
      self.field_helpers << "label"
      def label(method, text = nil, options = {})
        @template.label(@object_name, method, text, options.merge(:object => @object))
      end
    end
    
    class InstanceTag
      def to_label_tag(text = nil, options = {})
        return if text == false
        
        name_and_id = options.dup
        add_default_name_and_id(name_and_id)
        options["for"] = name_and_id["id"]
        content = text || method_name.humanize
        content = "#{content}#{options.delete(:separator)}"
        content_tag("label", content, options)
      end
    end  
  end
end
