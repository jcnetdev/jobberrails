require File.dirname(__FILE__) + '/../test_helper'

class ValidatesAsEmailAddressTest < Test::Unit::TestCase
  def test_should_require_legal_rfc822_format
    [
      'Max@Job 3:14', 
      'Job@Book of Job',
      'J. P. \'s-Gravezande, a.k.a. The Hacker!@example.com',
    ].each do |address|
      assert !User.new(:email => address).valid?, "#{address} should be illegal."
    end
    
    [
      'test@example',
      'test@example.com', 
      'test@example.co.uk',
      '"J. P. \'s-Gravezande, a.k.a. The Hacker!"@example.com',
      'me@[187.223.45.119]',
      'someone@123.com',
    ].each do |address|
      assert User.new(:email => address).valid?, "#{address} should be legal."
    end
  end
  
  def test_not_allow_email_addresses_longer_than_320_characters
    assert User.new(:email => 'a' * 314 + '@a.com').valid?
    assert !User.new(:email => 'a' * 315 + '@a.com').valid?
  end
end
