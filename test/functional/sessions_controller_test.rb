require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_should_login
    post :create, :login => "bob", :password => "test"
    assert session[:admin]
  end
  
  def test_should_redirect_after_successful_login
    post :create, :login => "bob", :password => "test"
    assert_response :redirect
    assert_redirected_to admin_jobs_url
  end
  
  def test_should_fail_login
    post :create, :login => 'quentin', :password => 'bad password'
    assert_nil session[:admin]
  end
  
  def test_should_show_error_after_failed_login
    post :create, :login => 'quentin', :password => 'bad password'
    
    assert_equal "Invalid login or password!", flash[:error]
  end
  
  def test_should_logout
    login_as(:admin)
    
    get :destroy
    assert_nil session[:admin]
  end

  def test_should_redirect_after_logout
    login_as(:admin)
    
    get :destroy
    assert_response :redirect
    assert_redirected_to login_url
  end
end
