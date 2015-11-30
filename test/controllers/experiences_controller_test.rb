require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  test "an elder define the experience of a hacker" do
    session[:hacker_id] = hackers(:leo).id
    post :create, hacker_id: hackers(:jorge),
                  experience: { level: 'competent', skill_id: skills(:tdd).id }
    assert_redirected_to hackers(:jorge)
    assert_equal 'competent', hackers(:jorge).experience(skills(:tdd)).level
  end

  test 'a junior user cannot change his experience' do
    post :create, hacker_id: hackers(:jorge),
                  experience: { level: 'expert', skill_id: skills(:tdd).id }
    assert_redirected_to hackers(:jorge)
    assert_equal 'beginner', hackers(:jorge).experience(skills(:tdd)).level
    assert_equal 'Action not allowed', flash[:alert]
  end
end
