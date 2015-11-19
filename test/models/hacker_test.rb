require 'test_helper'

class HackerTest < ActiveSupport::TestCase
  test "have a seniority" do
    assert_equal 2, hackers(:jorge).seniority
  end

  test "lacks two skills for next seniority" do
    missing = hackers(:jorge).missing_requirements_for_next_seniority
    assert_equal 2, missing.size
    assert_includes missing, requirements(:senior_js_ruby)
    assert_includes missing, requirements(:senior_js_tdd)
  end

  test 'have experience in some skills' do
    assert_equal 'beginner', hackers(:jorge).experience(skills(:tdd)).level
    assert_equal 'none', hackers(:jorge).experience(skills(:ruby)).level
  end
end
