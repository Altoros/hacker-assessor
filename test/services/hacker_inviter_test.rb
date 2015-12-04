require 'test_helper'

class HackerInviterTest < ActiveSupport::TestCase

  test 'add acquirements to match the given seniority' do
    hacker = hackers(:jorge)
    assert_equal 2, hacker.seniority
    HackerInviter.new(hacker).give_seniority(3)
    assert_equal 3, hacker.seniority(true)
  end

end
