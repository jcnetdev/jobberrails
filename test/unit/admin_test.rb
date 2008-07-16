require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def test_authentication    
    assert_not_nil Admin.authenticate("admin", "admin")
  end
    
  def test_valid_authentication
    assert_equal admins(:mark), Admin.authenticate("mark", "longtest")
  end
    
  def test_invalid_authentication_wrong_username
    assert_nil Admin.authenticate("adminnn", "admin") 
  end
    
  def test_invalid_authentication_wrong_password
    assert_nil Admin.authenticate("bob", "wrongpass")
  end

  def test_invalid_authentication_wrong_username_and_password
    assert_nil Admin.authenticate("nonbob", "wrongpass")
  end
end
