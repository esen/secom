require 'test_helper'

class Ort::PaymentsControllerTest < ActionController::TestCase
  setup do
    @ort_payment = ort_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ort_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ort_payment" do
    assert_difference('Ort::Payment.count') do
      post :create, ort_payment: { amount: @ort_payment.amount, ort_exam_id: @ort_payment.ort_exam_id, ort_participant_id: @ort_payment.ort_participant_id, paid_at: @ort_payment.paid_at }
    end

    assert_redirected_to ort_payment_path(assigns(:ort_payment))
  end

  test "should show ort_payment" do
    get :show, id: @ort_payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ort_payment
    assert_response :success
  end

  test "should update ort_payment" do
    put :update, id: @ort_payment, ort_payment: { amount: @ort_payment.amount, ort_exam_id: @ort_payment.ort_exam_id, ort_participant_id: @ort_payment.ort_participant_id, paid_at: @ort_payment.paid_at }
    assert_redirected_to ort_payment_path(assigns(:ort_payment))
  end

  test "should destroy ort_payment" do
    assert_difference('Ort::Payment.count', -1) do
      delete :destroy, id: @ort_payment
    end

    assert_redirected_to ort_payments_path
  end
end
