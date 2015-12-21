require 'test_helper'

class CareersControllerTest < ActionController::TestCase
  setup do
    @career = careers(:js)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:careers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create career with all the requirements from the csv" do
    assert_difference('Career.count') do
      post :create, career: {
        name: 'dev-ops',
        description: 'Like a sysadmin that write code',
        requirements: fixture_file_upload('files/dev-ops.csv')
      }
    end

    career = assigns(:career)
    refute career.requirements.empty?, 'requirements got there'
    assert_equal 'Like a sysadmin that write code', career.description
    assert_redirected_to career_path(career)
  end

  test 'fails on create with invalid csv' do
    assert_no_difference('Career.count') do
      post :create, career: {
        name: 'dev-ops',
        description: 'Like a sysadmin that write code',
        requirements: fixture_file_upload('files/invalid.csv')
      }
    end
  end

  test "should show career" do
    get :show, id: @career
    assert_response :success
  end

  test 'see a panorama of the career' do
    get :panorama, id: @career
    assert_response :success
    assert assigns(:panorama)
  end

  test "should get edit" do
    get :edit, id: @career
    assert_response :success
  end

  test "should update career requirements" do
    patch :update, id: @career, career: {
      name: @career.name,
      description: @career.description,
      requirements: fixture_file_upload('files/dev-ops.csv')
    }
    assert_redirected_to career_path(assigns(:career))
    assert_equal 3, @career.requirements(true).size
  end

  test 'updates career description without affecting requirements' do
    patch :update, id: @career, career: {
      name: @career.name,
      description: 'new description'
    }
    assert_equal 'new description', assigns(:career).description
  end

  test "should destroy a career without hackers" do
    assert_difference('Career.count', -1) do
      delete :destroy, id: careers(:ruby)
    end

    assert_redirected_to careers_path
  end

  test "careers with hackers cannot be destroyed" do
    assert_difference('Career.count', 0) do
      delete :destroy, id: careers(:js)
    end

    assert_redirected_to assigns(:career)
    assert_equal'Career could not be destroyed.', flash[:alert]
  end
end
