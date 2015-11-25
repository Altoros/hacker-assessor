require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  test "an elder define the experience of a hacker" do
    session[:current_hacker]
    post :create, hacker_id: hackers(:jorge),
                  experience: { level: 'competent', skill_id: skills(:tdd).id }
    assert_redirected_to hackers(:jorge)
    assert_equal 'competent', hackers(:jorge).experience(skills(:tdd)).level
  end
end
