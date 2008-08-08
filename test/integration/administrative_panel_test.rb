require 'test/test_helper'

class AdministrativePanelTest < ActionController::IntegrationTest
  
  def test_login_logout
    admin = admin_for_test
    admin.try_to_login
    admin.login    
    admin.logout
  end
  
  def test_jobs_management
    admin = admin_for_test
    admin.login
    
    admin.activate_inactive_job
    admin.deactivate_active_job
    
    admin.delete_active_job
    admin.delete_inactive_job
    
    admin.logout
  end
  
  def test_categories_management
    admin = admin_for_test
    admin.login
    
    admin.get_categories_list
    admin.add_new_category
    admin.update_category
    admin.sort_categories
    admin.delete_category
    
    admin.logout
  end
  
  def test_pages_management
    admin = admin_for_test
    admin.login
    
    admin.get_pages_list
    admin.create_page
    admin.update_page
    admin.delete_page
    
    admin.logout
  end 
  
  def admin_for_test
    open_session do |admin|
      def admin.try_to_login
        get "admin"
        assert_nil session[:admin]
        assert_response :redirect
        assert_redirected_to login_path
        post "session", :login => "test failure string", :password => "test failure string"
        assert_nil session[:admin]
        assert_equal "Invalid login or password!", flash[:error]
      end
      
      def admin.login
        get "login"
        assert_response :success
        assert_nil session[:admin]
        post "session", :login => 'admin', :password => 'admin'
        assert_not_nil session[:admin]
        assert_response :redirect
        assert_redirected_to admin_path
      end
      
      def admin.logout
        delete "logout"
        assert_response :redirect
        assert_redirected_to login_path
        assert_nil session[:admin]
      end
      
      def admin.activate_inactive_job
        get "admin"
        assert_response :success
        
        assert_not_nil assigns(:jobs)
        inactive_jobs_count = assigns(:jobs).size
        put "admin/jobs/#{assigns(:jobs).first.id}"
        assert_equal "Job has been activated", flash[:notice]
        
        get "admin"
        assert_equal inactive_jobs_count - 1, assigns(:jobs).size
      end
      
      def admin.deactivate_active_job
        get "admin/categories/#{categories(:designer).value}"
        assert_not_nil assigns(:jobs)
        active_jobs_count = assigns(:jobs).size
        put "admin/jobs/#{assigns(:jobs).first.id}"
        assert_equal "Job has been deactivated", flash[:notice]
        
        get "admin/categories/#{categories(:designer).value}"
        assert_equal active_jobs_count - 1, assigns(:jobs).size
      end
      
      def admin.delete_active_job
        get "admin/categories/#{categories(:programmer).value}"
        assert_not_nil assigns(:jobs)
        assert_difference("Job.count", -1) do
          xhr :delete, "admin/jobs/#{assigns(:jobs).first.id}"
        end
        
        assert_equal "Job has been deleted", flash[:notice]
      end
      
      def admin.delete_inactive_job
        get "admin"
        assert_not_nil assigns(:jobs)
        assert_difference("Job.count", -1) do
          xhr :delete, "admin/jobs/#{assigns(:jobs).first.id}"
        end
        
        assert_equal "Job has been deleted", flash[:notice]
      end
      
      def admin.get_categories_list
        get "admin/categories"
        assert_response :success
        assert_not_nil assigns(:categories) 
        assert_template "admin/categories/index"
      end
      
      def admin.add_new_category
        get_categories_list
        
        assert_difference("Category.count", 1) do
          xhr :post, 'admin/categories'
        end
        
        assert_equal "Category has been added", flash[:notice]
        assert_select_rjs :insert, :bottom, "categoriesContainer"
      end
      
      def admin.update_category
        get_categories_list
        
        xhr :put, "admin/categories/#{categories(:designer).id}", :name => 'New name', :url => categories(:designer).value
        assert_equal 'New name', categories(:designer).reload.name
        
        assert_equal "Category has been updated", flash[:notice]
      end
      
      def admin.sort_categories
        get_categories_list
        
        xhr :put, "admin/categories/saveorder", :categoriesContainer => [categories(:designer).id,categories(:administrator).id,categories(:programmer).id]
        assert_equal [1,2,3], [categories(:designer).reload.position, categories(:administrator).reload.position,categories(:programmer).reload.position]
        
        assert_equal "Categories order changed. Saving ...", flash[:notice]
      end
      
      def admin.delete_category
        get_categories_list
        
        assert_no_difference("Category.count") do
          xhr :delete, "admin/categories/#{categories(:designer).id}"
        end
        
        assert_difference("Category.count", -1) do
          xhr :delete, "admin/categories/#{categories(:administrator).id}"
        end
        
        assert_select_rjs :remove, categories(:administrator).dom_id
        assert_equal "Category has been deleted", flash[:notice]
      end
      
      def admin.get_pages_list
        get "admin/pages"
        assert_not_nil assigns(:pages) 
        assert_template "admin/pages/index"
      end
      
      def admin.create_page
        get_pages_list
        
        get 'admin/pages/new'
        assert_response :success
        assert_template "admin/pages/new"
        
        assert_difference("Page.count", 1) do
          post 'admin/pages', :page => {:title => 'Title', :url => 'urls'}
        end
        
        assert_response :redirect
        assert_redirected_to admin_pages_url 
        
        assert_equal "Page was successfully created.", flash[:notice]
      end
      
      def admin.update_page
        get_pages_list
        
        get "admin/pages/#{pages(:about).url}/edit"
        assert_response :success
        assert_template "admin/pages/edit"
        
        put "admin/pages/#{pages(:about).url}", :page => {:title => 'New title', :content => 'Some content'}
       
        assert_response :redirect
        assert_redirected_to admin_pages_url 
        assert_equal "Page was successfully updated.", flash[:notice]
      end
      
      def admin.delete_page
        get_pages_list
        
        assert_difference("Page.count", -1) do
          xhr :delete, "admin/pages/#{pages(:contact).url}"
        end
        
        assert_equal "Page has been deleted", flash[:notice]
      end
    end
  end
end
