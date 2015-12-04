require 'test_helper'

class HackersControllerTest < ActionController::TestCase
  setup do
    @hacker = hackers(:jorge)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hackers)
  end

  test "should get invite" do
    get :new
    assert_response :success
  end

  test "should invite a hacker" do
    assert_difference('Hacker.count') do
      post :create, hacker: { email: 'eloy@altoros.com',
                              name: 'eloy',
                              career_id: careers(:ruby),
                              password: 'eloy',
                              password_confirmation: 'eloy',
                              seniority: '1' }
    end

    assert_redirected_to hacker_path(assigns(:hacker))
  end

  test "should show hacker" do
    get :show, id: @hacker
    assert_response :success
  end

  test "show a hacker from an elder" do
    session[:hacker_id] = hackers(:leo).id
    get :show, id: @hacker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hacker
    assert_response :success
  end

  test "should update hacker" do
    patch :update, id: @hacker, hacker: { email: @hacker.email,
                                          name: @hacker.name,
                                          career_id: careers(:ruby),
                                          password: 'secret',
                                          password_confirmation: 'secret' }
    assert_redirected_to hacker_path(assigns(:hacker))
    assert_equal careers(:ruby), assigns(:hacker).career(true)
  end

  test "should destroy hacker" do
    assert_difference('Hacker.count', -1) do
      delete :destroy, id: @hacker
    end

    assert_redirected_to hackers_path
  end
end
