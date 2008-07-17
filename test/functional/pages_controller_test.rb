require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  def test_should_show_page
    get :show, :id => pages(:about).url
    assert_response :success
  end
  
  def test_should_show_page_form
    get :show, :id => pages(:contact).url
    assert_tag :tag => 'div', :attributes => { :id => 'contact-form'}
  end
  
  def test_should_not_show_page_form
    get :show, :id => pages(:about).url
    assert_no_tag :tag => 'div', :attributes => { :id => 'contact-form'}
  end
end
