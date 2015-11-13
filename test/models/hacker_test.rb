require 'test_helper'

class HackerTest < ActiveSupport::TestCase
  test "have a seniority" do
    assert_equal 2, hackers(:jorge).seniority
  end

  test 'have experience in some skills' do
    assert_equal 'beginner', hackers(:jorge).experience(skills(:tdd)).level
    assert_equal 'none', hackers(:jorge).experience(skills(:ruby)).level
  end
end
