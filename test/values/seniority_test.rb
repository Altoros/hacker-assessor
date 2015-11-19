require 'test_helper'

class SeniorityTest < ActiveSupport::TestCase

  test 'works as a number' do
    assert_equal 2, Seniority.new(2)
  end

  test 'shows as the name' do
    assert_equal 'Junior', Seniority.new(1).to_s
  end

end
