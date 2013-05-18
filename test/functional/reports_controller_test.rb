require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get funds" do
    get :funds
    assert_response :success
  end

end
