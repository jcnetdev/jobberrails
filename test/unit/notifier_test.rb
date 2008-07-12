require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  
  def test_assert_truth
    assert true
  end
  
  # TODO: fix these tests
  # def test_job_posted
  #   @expected.subject = "#{AppConfig.site_name} - Thanks for Posting"
  #   @expected.body    = read_fixture('job_posted')
  #   @expected.date    = Time.now
  # 
  #   assert_equal @expected.encoded, Notifier.create_job_posted(@expected.date).encoded
  # end
  # 
  # def test_somebody_applied
  #   @expected.subject = "#{AppConfig.site_name} - New Job Applicant"
  #   @expected.body    = read_fixture('somebody_applied')
  #   @expected.date    = Time.now
  # 
  #   assert_equal @expected.encoded, Notifier.create_somebody_applied(@expected.date).encoded
  # end

end
