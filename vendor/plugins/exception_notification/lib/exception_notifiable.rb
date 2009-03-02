require 'ipaddr'

module ExceptionNotifiable
  # exceptions of these types will not generate notification emails
  SILENT_EXCEPTIONS = [
    ActiveRecord::RecordNotFound,
    ActionController::UnknownController,
    ActionController::UnknownAction,
    ActionController::RoutingError,
    ActionController::MethodNotAllowed
  ]

  def self.included(base)
    base.extend ClassMethods

    base.cattr_accessor :silent_exceptions
    base.silent_exceptions = SILENT_EXCEPTIONS

    base.class_eval do
      alias_method_chain :rescue_action_in_public, :notification
    end
  end

  module ClassMethods
    # specifies ip addresses that should be handled as though local
    def consider_local(*args)
      local_addresses.concat(args.flatten.map { |a| IPAddr.new(a) })
    end

    def local_addresses
      addresses = read_inheritable_attribute(:local_addresses)
      unless addresses
        addresses = [IPAddr.new("127.0.0.1")]
        write_inheritable_attribute(:local_addresses, addresses)
      end
      addresses
    end

    # set the exception_data deliverer OR retrieve the exception_data
    def exception_data(deliverer = nil)
      if deliverer
        write_inheritable_attribute(:exception_data, deliverer)
      else
        read_inheritable_attribute(:exception_data)
      end
    end
  end

  private

    # overrides Rails' local_request? method to also check any ip
    # addresses specified through consider_local.
    def local_request?
      remote = IPAddr.new(request.remote_ip)
      !self.class.local_addresses.detect { |addr| addr.include?(remote) }.nil?
    end

    def rescue_action_in_public_with_notification(exception)
      unless self.class.silent_exceptions.any? {|klass| klass === exception}
        deliverer = self.class.exception_data
        data = case deliverer
          when nil then {}
          when Symbol then send(deliverer)
          when Proc then deliverer.call(self)
        end

        ExceptionNotifier.deliver_exception_notification(exception, self, request, data)
      end

      rescue_action_in_public_without_notification(exception)
    end
end
