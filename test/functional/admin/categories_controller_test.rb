require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  def test_should_show_category_and_active_jobs
    login_as(:mark)
    get :show, :id => categories(:programmer).name
    assert_response :success
    assert_not_nil assigns(:jobs)
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
  
  def test_should_update_category    
    login_as(:admin)
    get :index
    xhr :put, :update, {:id => categories(:programmer).id, :name => "New name", :url => 'new_value23'}
    assert_response :success
    categories(:programmer).reload
    assert_equal('New name', categories(:programmer).name)
  end
  
  def test_should_not_update_category
    login_as(:mark)
    category = categories(:programmer)
    xhr :put, :update, {:id => categories(:programmer).id, :name => "Programmers", :url => 'new_value23'}
    categories(:programmer).reload
    assert_equal category.name, categories(:programmer).name
  end
  
  def test_should_delete_category_without_jobs
    login_as(:bob)
    assert_difference('Category.count', -1) do
      xhr :delete, :destroy, :id => categories(:administrator).id
    end    
    assert_response :success
    assert_select_rjs :remove, "category_#{categories(:administrator).id}"
  end
  
  def test_should_not_delete_category_with_jobs
    login_as(:bob)
    count = Category.count
    xhr :delete, :destroy, :id => categories(:programmer).id
    assert_equal(count, Category.count)
  end
  
  def test_should_change_order
    login_as(:mark)
    xhr :put, :saveorder, :categoriesContainer => [categories(:administrator).id, categories(:programmer).id, categories(:designer).id]
    categories(:administrator).reload
    assert_equal 0, categories(:administrator).position
    categories(:designer).reload
    assert_equal 2, categories(:designer).position
  end
end
