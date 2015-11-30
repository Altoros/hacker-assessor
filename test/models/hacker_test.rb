require 'test_helper'

class HackerTest < ActiveSupport::TestCase
  test "have a seniority" do
    assert_equal 2, hackers(:rodrigo).seniority
  end

  test "lacks two skills for next seniority" do
    missing = hackers(:rodrigo).missing_requirements_for_next_seniority
    assert_equal 2, missing.size
    assert_includes missing, requirements(:senior_js_js)
    assert_includes missing, requirements(:senior_js_tdd)
  end

  test 'have experience in some skills' do
    assert_equal 'beginner', hackers(:jorge).experience(skills(:tdd)).level
    assert_equal 'none', hackers(:jorge).experience(skills(:ruby)).level
    assert_equal 2, hackers(:jorge).acquirements.size, 'creates extra objects'
  end

  test 'Senior hackers are elders' do
    refute hackers(:jorge).is_elder?, 'jorge is elder'
    assert hackers(:leo).is_elder?, 'leo is not elder'
  end
end
