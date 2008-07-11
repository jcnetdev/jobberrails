require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_should_login_and_redirect
    post :create, :login => "bob", :password => "test"
    assert session[:admin]
    assert_response :redirect
    assert_redirected_to admin_jobs_url
  end
  
  def test_should_fail_login_and_not_redirect
    post :create, :login => 'quentin', :password => 'bad password'
    assert_nil session[:admin]
    assert_response :success
  end
  
  def test_should_login_and_logout
    post :create, :login => "admin", :password => "admin"
    assert session[:admin]
    assert_response :redirect
    assert_redirected_to admin_jobs_url
    
    get :destroy
    assert_nil session[:admin]
    assert_response :redirect
    assert_redirected_to login_url
  end

end
