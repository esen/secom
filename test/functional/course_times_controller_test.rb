require 'test_helper'

class CourseTimesControllerTest < ActionController::TestCase
  setup do
    @course_time = course_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_time" do
    assert_difference('CourseTime.count') do
      post :create, course_time: { ends_at: @course_time.ends_at, starts_at: @course_time.starts_at }
    end

    assert_redirected_to course_time_path(assigns(:course_time))
  end

  test "should show course_time" do
    get :show, id: @course_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_time
    assert_response :success
  end

  test "should update course_time" do
    put :update, id: @course_time, course_time: { ends_at: @course_time.ends_at, starts_at: @course_time.starts_at }
    assert_redirected_to course_time_path(assigns(:course_time))
  end

  test "should destroy course_time" do
    assert_difference('CourseTime.count', -1) do
      delete :destroy, id: @course_time
    end

    assert_redirected_to course_times_path
  end
end
