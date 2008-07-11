require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def test_authentication
    
    assert_not_nil Admin.authenticate("admin", "admin")
    
    assert_equal admins(:mark), Admin.authenticate("mark", "longtest")
    
    # wrong username
    assert_nil Admin.authenticate("adminnn", "admin") 
    
    #wrong password
    assert_nil Admin.authenticate("bob", "wrongpass")

    #wrong login and pass
    assert_nil Admin.authenticate("nonbob", "wrongpass")
  end
end
