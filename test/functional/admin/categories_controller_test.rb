require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  def test_should_show_category
    login_as(:mark)
    get :show, :id => categories(:programmer).name
    assert_response :success
  end
  
  def test_shouls_show_category_jobs
    login_as(:mark)
    get :show, :id => categories(:programmer).name
    assert_not_nil assigns(:jobs)
  end
  
  def test_should_show_category_active_jobs
    login_as(:mark)
    get :show, :id => categories(:programmer).name
    
    assigns(:jobs).each do |job|
      assert_equal categories(:programmer).name, job.category.name
      assert job.is_active
    end
  end
  
  def test_should_get_categories
    login_as(:admin)
    get :index
    assert_equal Category.count, assigns(:categories).size
  end
  
  def test_should_create_category
    login_as(:mark)
    assert_difference('Category.count') do
      xhr :post, :create
    end
    assert_select_rjs :insert_html, :bottom, 'categoriesContainer'
  end
  
  def test_should_insert_category_at_bottom
    login_as(:mark)
    xhr :post, :create
    assert_select_rjs :insert_html, :bottom, 'categoriesContainer'
  end
  
  def test_should_update_category    
    login_as(:admin)
    xhr :put, :update, {:id => categories(:programmer).id, :name => "New name", :url => 'new_value23'}
    assert_response :success
  end
  
  def test_should_update_category_name
    login_as(:admin)
    xhr :put, :update, {:id => categories(:programmer).id, :name => "New name", :url => categories(:programmer).value}
    categories(:programmer).reload
    assert_equal('New name', categories(:programmer).name)
  end
  
  def test_should_update_category_value
    login_as(:admin)
    xhr :put, :update, {:id => categories(:programmer).id, :name => categories(:programmer).name, :url => 'new_url_1234'}
    categories(:programmer).reload
    assert_equal('new_url_1234', categories(:programmer).value)
  end
  
  def test_should_not_update_category
    login_as(:mark)
    category = categories(:programmer)
    xhr :put, :update, {:id => categories(:programmer).id, :name => "Programmers", :url => 'new_value23'}
    categories(:programmer).reload
    assert_equal category, categories(:programmer)
  end
  
  def test_should_delete_category_without_jobs
    login_as(:bob)
    assert_difference('Category.count', -1) do
      xhr :delete, :destroy, :id => categories(:administrator).id
    end    
    assert_response :success
    assert_select_rjs :remove, categories(:administrator).dom_id
  end
  
  def test_should_remove_category
    login_as(:bob)
    xhr :delete, :destroy, :id => categories(:administrator).id
    assert_select_rjs :remove, categories(:administrator).dom_id
  end
  
  def test_should_not_delete_category_with_jobs
    login_as(:bob)
    assert_no_difference("Category.count") do
      xhr :delete, :destroy, :id => categories(:programmer).id
    end
  end
  
  def test_should_change_order
    login_as(:mark)
    xhr :put, :saveorder, :categoriesContainer => [categories(:administrator).id, categories(:programmer).id, categories(:designer).id]
    categories(:administrator).reload
    categories(:programmer).reload
    categories(:designer).reload
    assert_equal [1, 2, 3], [categories(:administrator).position, categories(:programmer).position, categories(:designer).position]
  end
end
