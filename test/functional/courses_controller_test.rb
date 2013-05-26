require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { branch_id: @course.branch_id, course_time_id: @course.course_time_id, friday: @course.friday, group_id: @course.group_id, lesson_id: @course.lesson_id, monday: @course.monday, room_id: @course.room_id, saturday: @course.saturday, sunday: @course.sunday, teacher_id: @course.teacher_id, thursday: @course.thursday, tuesday: @course.tuesday, wednesday: @course.wednesday }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    put :update, id: @course, course: { branch_id: @course.branch_id, course_time_id: @course.course_time_id, friday: @course.friday, group_id: @course.group_id, lesson_id: @course.lesson_id, monday: @course.monday, room_id: @course.room_id, saturday: @course.saturday, sunday: @course.sunday, teacher_id: @course.teacher_id, thursday: @course.thursday, tuesday: @course.tuesday, wednesday: @course.wednesday }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
