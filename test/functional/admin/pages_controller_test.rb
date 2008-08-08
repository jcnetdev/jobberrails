require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  
  def test_should_get_pages_index
    login_as(:admin)
    get :index
    assert_equal Page.count, assigns(:pages).size
  end
  
  def test_should_get_new
    login_as :bob
    get :new
    assert_response :success
  end
  
  def test_should_create_page
    login_as :bob
    assert_difference('Page.count') do
      post :create, :page => {:title => "Japan", :url => "country_japan"}
    end
  end
  
  def test_should_redirect_after_creating
    login_as :bob
    post :create, :page => {:title => "About Us", :url => "about_us"}    

    assert_redirected_to admin_pages_path
  end
  
  def test_should_get_edit
    login_as :admin
    get :edit, :id => pages(:about).url
    assert_response :success
  end
  
  def test_should_update_page
    login_as :bob
    put :update, :id => pages(:contact).url, :page => {:has_form => true, :content => '<b>Some text</b>'}
    assert_response :redirect
  end
  
  def test_should_destroy_page
    login_as :admin
    assert_difference('Page.count', -1) do
      xhr :delete, :destroy, :id => pages(:about).url
    end
  end  
end
