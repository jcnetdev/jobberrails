require 'test_helper'

class Admin::JobsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as(:bob)
    get :index
    assert_response :success
  end
  
  def test_should_get_inactive_jobs
    login_as(:admin)
    get :index
    assert_not_nil assigns(:jobs)
  end
  
  def test_should_destroy_inactive_job
    login_as(:bob)
    assert_difference('Job.count', -1) do
      xhr :delete, :destroy, :id => jobs(:two).id
    end    
    assert_response :success
  end
  
  def test_should_destroy_active_job
    login_as(:bob)
    assert_difference('Job.count', -1) do
      xhr :delete, :destroy, :id => jobs(:one).id
    end    
    assert_response :success
  end
  
  def test_should_activate_inactive_job
    login_as(:admin)
    xhr :put, :update, :id => jobs(:two).id
    assert_response :success
  end
  
  def test_should_not_show_inactive_jobs
    login_as(:admin)
    change_job_is_active(:two)
    get :index
    assert_equal 0, assigns(:jobs).size
  end
  
  def test_should_deactivate_active_job
    login_as(:admin)
    xhr :put, :update, :id => jobs(:one).id
    assert_response :success
  end
  
  def test_should_increase_inactive_job_index
    login_as(:admin)
    change_job_is_active(:one)
    get :index
    assert_equal 2, assigns(:jobs).size
  end
  
  private
  def change_job_is_active(job)
    xhr :put, :update, :id => jobs(job).id
  end
end
