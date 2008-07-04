require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures  = true

  def test_authentication
    assert_equal @mark, Admin.authenticate("mark", "longtest")
    
    # wrong username
    assert_nil Admin.authenticate("adminnn", "admin") 
    
    #wrong password
    assert_nil Admin.authenticate("bob", "wrongpass")

    #wrong login and pass
    assert_nil Admin.authenticate("nonbob", "wrongpass")
  end
end
