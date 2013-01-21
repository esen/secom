require 'test_helper'

class Ort::ExamTypesControllerTest < ActionController::TestCase
  setup do
    @ort_exam_type = ort_exam_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ort_exam_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ort_exam_type" do
    assert_difference('Ort::ExamType.count') do
      post :create, ort_exam_type: { cost: @ort_exam_type.cost, name: @ort_exam_type.name }
    end

    assert_redirected_to ort_exam_type_path(assigns(:ort_exam_type))
  end

  test "should show ort_exam_type" do
    get :show, id: @ort_exam_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ort_exam_type
    assert_response :success
  end

  test "should update ort_exam_type" do
    put :update, id: @ort_exam_type, ort_exam_type: { cost: @ort_exam_type.cost, name: @ort_exam_type.name }
    assert_redirected_to ort_exam_type_path(assigns(:ort_exam_type))
  end

  test "should destroy ort_exam_type" do
    assert_difference('Ort::ExamType.count', -1) do
      delete :destroy, id: @ort_exam_type
    end

    assert_redirected_to ort_exam_types_path
  end
end
