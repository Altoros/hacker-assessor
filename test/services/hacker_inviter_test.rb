require 'test_helper'

class HackerInviterTest < ActiveSupport::TestCase
  test "add acquirements when a hacker is invted" do
    params = { email: 'semi-senior@hacker.com',
               name: 'SemiSenior JS',
               career_id: careers(:js).id,
               password: 'password',
               password_confirmation: 'password',
               seniority: '3' }

    HackerInviter.new(params)
    assert_equal Hacker.find_by(email: 'semi-senior@hacker.com').seniority, '3'
  end
end
