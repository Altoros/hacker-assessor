require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get hacker index" do
    session[:hacker_id] = hackers(:jorge).id
    get :index
    assert_response :success
  end

  test "should get admin index" do
    get :index
    assert_response :redirect
  end
end
