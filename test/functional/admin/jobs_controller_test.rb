require 'test_helper'

class Admin::JobsControllerTest < ActionController::TestCase
  def test_should_get_inactive_jobs_index
    login_as(:admin)
    get :index
    assert_response :success
  end
  
  def test_should_destroy_inactive_job
    login_as(:bob)
    assert_difference('Job.count', -1) do
      xhr :delete, :destroy, :id => jobs(:one).id
    end    
    assert_response :success
  end
  
  def test_should_activate_inactive_job
    login_as(:admin)
    get :index
    assert_equal 1, assigns(:jobs).size
    assert_equal false, jobs(:two).is_active
    xhr :put, :update, :id => jobs(:two).id
    assert_response :success
    jobs(:two).reload
    assert jobs(:two).is_active
    get :index
    assert_equal 0, assigns(:jobs).size
  end
  
  def test_should_deactivate_active_job
    login_as(:admin)
    get :index
    assert_equal 1, assigns(:jobs).size
    assert jobs(:one).is_active
    xhr :put, :update, :id => jobs(:one).id
    assert_response :success
    jobs(:one).reload
    assert_equal false, jobs(:one).is_active
    get :index
    assert_equal 2, assigns(:jobs).size
  end
end
