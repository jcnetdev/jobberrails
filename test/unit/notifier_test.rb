require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  def test_jobposted
    @expected.subject = 'Notifier#jobposted'
    @expected.body    = read_fixture('jobposted')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_jobposted(@expected.date).encoded
  end

  def test_somebodyapplied
    @expected.subject = 'Notifier#somebodyapplied'
    @expected.body    = read_fixture('somebodyapplied')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_somebodyapplied(@expected.date).encoded
  end

end
