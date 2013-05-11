require 'test_helper'

class PaymentDatesControllerTest < ActionController::TestCase
  setup do
    @payment_date = payment_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_date" do
    assert_difference('PaymentDate.count') do
      post :create, payment_date: { amount: @payment_date.amount, group_id: @payment_date.group_id, payment_date: @payment_date.payment_date }
    end

    assert_redirected_to payment_date_path(assigns(:payment_date))
  end

  test "should show payment_date" do
    get :show, id: @payment_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_date
    assert_response :success
  end

  test "should update payment_date" do
    put :update, id: @payment_date, payment_date: { amount: @payment_date.amount, group_id: @payment_date.group_id, payment_date: @payment_date.payment_date }
    assert_redirected_to payment_date_path(assigns(:payment_date))
  end

  test "should destroy payment_date" do
    assert_difference('PaymentDate.count', -1) do
      delete :destroy, id: @payment_date
    end

    assert_redirected_to payment_dates_path
  end
end
