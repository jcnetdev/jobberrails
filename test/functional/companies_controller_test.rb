require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  
  def test_should_get_companies_index
    get :index    
    assert_response :success
  end
  
  def test_should_show_companies_list
    get :index    
    assert_not_nil assigns(:companies)
  end
  
  def test_should_have_css_class
    get :index
    assert_tag :tag => "span", :attributes => {:class => "company-tag-2"}
  end
  
  def test_should_show_jobs_at
    get :jobs_at, :company => ERB::Util.url_encode(jobs(:one).company)
    assert_not_nil assigns(:jobs)
  end
  
  def test_should_not_show_jobs_at
    get :jobs_at, :company => "some fake url"
    assert_nil assigns(:jobs)
  end
end
