class Notifier < ActionMailer::Base
  

  def jobposted(recipient, company, sent_at = Time.now)
    subject    'thanks for posting'
    recipients recipient
    from       'jobs@'
    sent_on    sent_at
    content_type "multipart/alternative"
    
    part :content_type => "text/plain",
      :body =>  render_message("jobposted", :company => company)

  end

  def somebodyapplied(recipient, name, message, filename, id, sent_at = Time.now)
    subject    'somebody applied'
    recipients recipient
    from       'jobs@'
    sent_on    sent_at
    content_type "multipart/alternative"
    
    part :content_type => "text/plain",
      :body =>  render_message("somebodyapplied", :name => name, :message => message, :filename => filename, :id => id)

  end

end
