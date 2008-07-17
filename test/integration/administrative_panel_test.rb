require 'test_helper'

class AdministrativePanelTest < ActionController::IntegrationTest
  
  def test_login_logout
    get '/admin/jobs'
    assert_response :redirect
    
    assert_equal 'Please log in.', flash[:notice]

    post '/session', {:login => 'admin', :password => 'admin'}
    assert_response :redirect
    
    assert session[:admin]
    
    post '/logout'
    assert_response :redirect
    assert_nil session[:admin]
  end
  
  def test_activate_and_deactivate_jobs
    login_user
    
    # activate deactive job
    put "/admin/jobs/#{jobs(:two).id}"
    jobs(:two).reload
    assert jobs(:two).is_active
    
    # deactivate active job
    get "/admin/categories/#{jobs(:two).category}"
    put "/admin/jobs/#{jobs(:two).id}"
    jobs(:two).reload
    assert_equal(false, jobs(:two).is_active)
    assert_equal "Job has been activated/deactivated", flash[:notice]
    
    logout_user
  end
  
  def test_delete_job
    login_user
    
    # inactive job
    delete "/admin/jobs/#{jobs(:two).id}"
    assert_raise(ActiveRecord::RecordNotFound) { jobs(:two).reload }
    
    # active job
    delete "/admin/jobs/#{jobs(:one).id}"
    assert_raise(ActiveRecord::RecordNotFound) { jobs(:one).reload }
    
    logout_user
  end
  
  def test_manage_categories
    login_user
    
    get '/admin/categories'
    assert_response :success
        
    # add category
    assert_difference("Category.count", 1) do
      post '/admin/categories'
    end
    
    # update category name
    put "/admin/categories/#{categories(:designer).id}", :name => 'New name', :url => categories(:designer).value
    categories(:designer).reload
    assert_equal 'New name', categories(:designer).name
    
    # sort categories
    put '/admin/categories/saveorder', :categoriesContainer => [categories(:designer).id,categories(:administrator).id,categories(:programmer).id]
    assert_equal [1,2,3], [categories(:designer).reload.position, categories(:administrator).reload.position,categories(:programmer).reload.position]
    
    # should not delete category with jobs
    assert_no_difference("Category.count") do
      delete "/admin/categories/#{categories(:designer).id}"
    end
    
    # should delete category without jobs
    assert_difference("Category.count", -1) do
      delete "/admin/categories/#{categories(:administrator).id}"
    end
        
    logout_user
  end
  
  def test_manage_pages
    login_user
    
    get '/admin/pages'
    assert_response :success
    
    get '/admin/pages/new'
    assert_response :success
    
    # add category
    assert_difference("Page.count", 1) do
      post '/admin/pages', :page => {:title => 'Title', :url => 'urls'}
    end
    
    assert_redirected_to admin_pages_url
    
    get "/admin/pages/#{pages(:about).url}/edit"
    assert_response :success
    
    # update page
    put "/admin/pages/#{pages(:about).url}", :page => {:title => 'New title', :content => 'Some content'}
    assert_response :redirect
    
    assert_redirected_to admin_pages_url
    
    pages(:about).reload
    assert_equal 'New title', pages(:about).title
        
    # delete page
    assert_difference("Page.count", -1) do
      delete "/admin/pages/#{pages(:contact).url}"
    end
    
    logout_user
  end
  
  private
  def login_user
    post '/session', {:login => 'admin', :password => 'admin'}
    assert_response :redirect
  end
  
  def logout_user
    post '/logout'
    assert_response :redirect
  end
end
