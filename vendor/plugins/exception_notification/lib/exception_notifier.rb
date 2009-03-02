require 'pathname'

class ExceptionNotifier < ActionMailer::Base
  @@sender_address = %("Exception Notifier" <exception.notifier@default.com>)
  cattr_accessor :sender_address

  @@exception_recipients = []
  cattr_accessor :exception_recipients

  @@email_prefix = "[ERROR] "
  cattr_accessor :email_prefix

  @@sections = %w(request session environment backtrace)
  cattr_accessor :sections

  self.template_root = "#{File.dirname(__FILE__)}/../views"

  def self.reloadable?() false end

  def exception_notification(exception, controller = nil, request = nil, data={})
    data = data.merge({
      :exception => exception,
      :backtrace => sanitize_backtrace(exception.backtrace),
      :rails_root => rails_root,
      :data => data
    })

    if controller and request
      data.merge!({
        :location => "#{controller.controller_name}##{controller.action_name}",
        :controller => controller,
        :request => request,
        :host => (request.env["HTTP_X_FORWARDED_HOST"] || request.env["HTTP_HOST"]),
        :sections => sections
      })
    else
      # TODO: with refactoring, the environment section could show useful ENV data even without a request
      data.merge!({
        :location => sanitize_backtrace([exception.backtrace.first]).first,
        :sections => sections - %w(request session environment)
      })
    end

    content_type "text/plain"

    recipients exception_recipients
    from       sender_address

    subject    "#{email_prefix}#{data[:location]} (#{exception.class}) #{exception.message.inspect}"
    body       data
  end

  private

    def sanitize_backtrace(trace)
      re = Regexp.new(/^#{Regexp.escape(rails_root)}/)
      trace.map { |line| Pathname.new(line.gsub(re, "[RAILS_ROOT]")).cleanpath.to_s }
    end

    def rails_root
      @rails_root ||= Pathname.new(RAILS_ROOT).cleanpath.to_s
    end

end
