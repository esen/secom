require 'test_helper'

class Ort::ParticipantsControllerTest < ActionController::TestCase
  setup do
    @ort_participant = ort_participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ort_participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ort_participant" do
    assert_difference('Ort::Participant.count') do
      post :create, ort_participant: { name: @ort_participant.name, password: @ort_participant.password, registered_at: @ort_participant.registered_at }
    end

    assert_redirected_to ort_participant_path(assigns(:ort_participant))
  end

  test "should show ort_participant" do
    get :show, id: @ort_participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ort_participant
    assert_response :success
  end

  test "should update ort_participant" do
    put :update, id: @ort_participant, ort_participant: { name: @ort_participant.name, password: @ort_participant.password, registered_at: @ort_participant.registered_at }
    assert_redirected_to ort_participant_path(assigns(:ort_participant))
  end

  test "should destroy ort_participant" do
    assert_difference('Ort::Participant.count', -1) do
      delete :destroy, id: @ort_participant
    end

    assert_redirected_to ort_participants_path
  end
end
