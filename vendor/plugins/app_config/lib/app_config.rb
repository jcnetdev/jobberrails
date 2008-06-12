# Application wide config parameters container.
#
# Assume that there is a following line in environment.rb:
#
#   Rails::Initializer.run do |config|
#       ...
#       config.app_config.mail_from_address = 'sender@address.com'
#       ...
#   end
#
# Access to above value in run time:
# * accessor method:
#    AppConfig.mail_from_address
#    AppConfig.mail_from_address
#
# * hash like methods (keys either as symbol or string):
#    AppConfig[:mail_from_address]
#    AppConfig['mail_from_address']
#
# * param() method with optional default value (which
#   is returned if parameter is nil)
#    AppConfig.param(:mail_from_address, 'default@address.com')
#    AppConfig.param('mail_from_address', 'default@address.com')
#
# * param() method with block executed when parameter is nil
#    AppConfig.param(:mail_from_address) do |conf|
#       raise StandardError, "Mail address is not poperly configured."
#    end
# NOTE: use either default value argument OR block
#
# * safe parameter testing
#    AppConfig.has_param?(:mail_from_address)
#    AppConfig.has_param?('mail_from_address')
#
# NOTE: if config.app_config.my_param=nil then AppConfig.has_param?(:my_param)
# will returns true. Parameter 'my_param' exists and has value nil.
#
# Author:: Daniel Owsianski (daniel-at-jarmark-dot-org)
module AppConfig
    # Name 'Base' for this class is required by
    # Initializer#initialize_framework_settings method.
    class Base #:nodoc
        @@parameters = OrderedOptions.new

        def self.method_missing(name, *arguments)
            @@parameters.method_missing(name, *arguments)
        end

        protected
        def self.parameters
            @@parameters
        end

        def self.has_param?(name)
            key = name.to_sym
            @@parameters.each{|i| return true if i.first == key}
            return false
        end
    end

    # When parameter with 'name' is nil method either returns
    # default value or (if default=nil) executes given block.
    # Note: either default value or block is allowed.
    def self.param(name, default=nil, &block)
        if block && default
            raise ArgumentError, "AppConfig cannot mix a default value argument with a block !"
        end

        value = Base.parameters[name]
        if value.nil? && block
            return yield(self)
        end

        value.nil? ? default : value
    end

    # Returns true if a given parameter name exists internal parameters storage.
    # Note: parameter can has nil value
    def self.has_param?(name)
        Base.has_param?(name)
    end

    # Read-only access to config properties.
    def self.method_missing(name, *arguments)
        case
        when name.to_s=='[]'
            Base.parameters[arguments.first]
        when !arguments.empty?
            # small trick, methods with name= usual has arguments
            # so faster is to check is array empty than e.g. name.to_s[-1,1] == '='
            super
        else
            Base.parameters[name]
        end
    end
end