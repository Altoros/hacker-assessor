require 'test_helper'

class SeniorityTest < ActiveSupport::TestCase

  test 'works as a number' do
    assert_equal 2, Seniority.new(2)
  end

  test 'shows as the name' do
    assert_equal 'Junior', Seniority.new(1).to_s
  end

  test 'comparing seniorities' do
    assert Seniority.new(2) > Seniority.new(1)
  end

  test 'get the seniority names with his index' do
    name, index = Seniority.options.first
    assert_equal Seniority::NAMES[index], name
  end

  test 'get the next seniority' do
    assert_equal 3, Seniority.new(2).next
  end

  test 'the next seniority doesn\'t exists' do
    assert_equal 9, Seniority.new(9).next
  end
end
