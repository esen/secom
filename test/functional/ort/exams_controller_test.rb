require 'test_helper'

class Ort::ExamsControllerTest < ActionController::TestCase
  setup do
    @ort_exam = ort_exams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ort_exams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ort_exam" do
    assert_difference('Ort::Exam.count') do
      post :create, ort_exam: { cost: @ort_exam.cost, ort_exam_type1: @ort_exam.ort_exam_type1, ort_exam_type2_id: @ort_exam.ort_exam_type2_id, ort_exam_type3_id: @ort_exam.ort_exam_type3_id, ort_exam_type4_id: @ort_exam.ort_exam_type4_id, ort_exam_type5_id: @ort_exam.ort_exam_type5_id, was_at: @ort_exam.was_at }
    end

    assert_redirected_to ort_exam_path(assigns(:ort_exam))
  end

  test "should show ort_exam" do
    get :show, id: @ort_exam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ort_exam
    assert_response :success
  end

  test "should update ort_exam" do
    put :update, id: @ort_exam, ort_exam: { cost: @ort_exam.cost, ort_exam_type1: @ort_exam.ort_exam_type1, ort_exam_type2_id: @ort_exam.ort_exam_type2_id, ort_exam_type3_id: @ort_exam.ort_exam_type3_id, ort_exam_type4_id: @ort_exam.ort_exam_type4_id, ort_exam_type5_id: @ort_exam.ort_exam_type5_id, was_at: @ort_exam.was_at }
    assert_redirected_to ort_exam_path(assigns(:ort_exam))
  end

  test "should destroy ort_exam" do
    assert_difference('Ort::Exam.count', -1) do
      delete :destroy, id: @ort_exam
    end

    assert_redirected_to ort_exams_path
  end
end
