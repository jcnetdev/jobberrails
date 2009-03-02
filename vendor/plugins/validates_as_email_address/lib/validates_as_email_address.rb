require 'validates_as_email_address/rfc_822'

module PluginAWeek #:nodoc:
  # Adds validations for email addresses
  module ValidatesAsEmailAddress
    # The options that can be used when validating the format of the email address
    EMAIL_FORMAT_OPTIONS = [
      :wrong_format,
      :allow_nil,
      :allow_blank,
      :message,
      :on,
      :if
    ]
    
    # The options that can be used when validating the length of the email address
    EMAIL_LENGTH_OPTIONS = [
      :minimum,
      :maximum,
      :is,
      :within,
      :in,
      :too_long,
      :too_short,
      :wrong_length,
      :allow_nil,
      :on,
      :if
    ]
    
    # Validates whether the value of the specific attribute matches against the
    # RFC822 specificiation.
    # 
    #   class Person < ActiveRecord::Base
    #     validates_as_email_address :email, :on => :create
    #   end
    # 
    # This will also validate that the email address is within the specification
    # limits, specifically between 3 and 320 characters in length.
    # 
    # Configuration options for length:
    # * +minimum+ - The minimum size of the attribute
    # * +maximum+ - The maximum size of the attribute
    # * +is+ - The exact size of the attribute
    # * +within+ - A range specifying the minimum and maximum size of the attribute
    # * +in+ - A synonym(or alias) for :within
    # * +too_long+ - The error message if the attribute goes over the maximum (default is: "is too long (maximum is %d characters)")
    # * +too_short+ - The error message if the attribute goes under the minimum (default is: "is too short (minimum is %d characters)")
    # * +wrong_length+ - The error message if using the :is method and the attribute is the wrong size (default is: "is the wrong length (should be %d characters)")
    # 
    # Configuration options for format:
    # * +wrong_format+ - A custom error message (default is: "is an invalid email address")
    # 
    # Configuration options for both length and format:
    # * +allow_nil+ - Attribute may be nil; skip validation.
    # * +on+ - Specifies when this validation is active (default is :save, other options :create, :update)
    # * +if+ - Specifies a method, proc or string to call to determine if the validation should
    # occur (e.g. :if => :allow_validation, or :if => Proc.new { |user| user.signup_step > 2 }).  The
    # method, proc or string should return or evaluate to a true or false value.
    def validates_as_email_address(*attr_names)
      configuration = attr_names.last.is_a?(Hash) ? attr_names.pop : {}
      configuration.assert_valid_keys(EMAIL_FORMAT_OPTIONS | EMAIL_LENGTH_OPTIONS)
      configuration.reverse_merge!(
        :wrong_format => ActiveRecord::Errors.default_error_messages[:invalid_email]
      )
      
      # Add format validation
      format_configuration = configuration.reject {|key, value| !EMAIL_FORMAT_OPTIONS.include?(key)}
      format_configuration[:message] = format_configuration.delete(:wrong_format)
      format_configuration[:with] = RFC822::EmailAddress
      validates_format_of attr_names, format_configuration
      
      # Add length validation
      length_configuration = configuration.reject {|key, value| !EMAIL_LENGTH_OPTIONS.include?(key)}
      length_configuration.reverse_merge!(:within => 3..320, :allow_blank => true)
      validates_length_of attr_names, length_configuration
    end
  end
end

ActiveRecord::Base.class_eval do
  extend PluginAWeek::ValidatesAsEmailAddress
end

ActiveRecord::Errors.default_error_messages.update(
  :invalid_email => 'is an invalid email address'
)
