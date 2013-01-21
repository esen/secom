require 'test_helper'

class Ort::ChequesControllerTest < ActionController::TestCase
  setup do
    @ort_cheque = ort_cheques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ort_cheques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ort_cheque" do
    assert_difference('Ort::Cheque.count') do
      post :create, ort_cheque: { enrolled_at: @ort_cheque.enrolled_at, mark1: @ort_cheque.mark1, mark2: @ort_cheque.mark2, mark3: @ort_cheque.mark3, mark4: @ort_cheque.mark4, mark5: @ort_cheque.mark5, ort_exam_id: @ort_cheque.ort_exam_id, ort_participant_id: @ort_cheque.ort_participant_id }
    end

    assert_redirected_to ort_cheque_path(assigns(:ort_cheque))
  end

  test "should show ort_cheque" do
    get :show, id: @ort_cheque
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ort_cheque
    assert_response :success
  end

  test "should update ort_cheque" do
    put :update, id: @ort_cheque, ort_cheque: { enrolled_at: @ort_cheque.enrolled_at, mark1: @ort_cheque.mark1, mark2: @ort_cheque.mark2, mark3: @ort_cheque.mark3, mark4: @ort_cheque.mark4, mark5: @ort_cheque.mark5, ort_exam_id: @ort_cheque.ort_exam_id, ort_participant_id: @ort_cheque.ort_participant_id }
    assert_redirected_to ort_cheque_path(assigns(:ort_cheque))
  end

  test "should destroy ort_cheque" do
    assert_difference('Ort::Cheque.count', -1) do
      delete :destroy, id: @ort_cheque
    end

    assert_redirected_to ort_cheques_path
  end
end
