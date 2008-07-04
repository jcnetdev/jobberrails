require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  def test_should_show_active_jobs_in_category
    login_as(:mark)
    get :show, :id => categories(:programmer).name
    assert_response :success
    assert_not_nil assigns(:jobs)
    assigns(:jobs).each do |job|
      assert_equal categories(:programmer).name, job.category.name
      assert job.is_active
    end
  end
end
