require 'test_helper'

class StyleguideControllerTest < ActionController::TestCase
  test "should get styleguide" do
    get :index
    assert_response :success
  end
end
