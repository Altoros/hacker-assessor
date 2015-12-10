require 'test_helper'

class SeniorityTest < ActiveSupport::TestCase

  test 'works as a number' do
    assert_equal 2, Seniority.new(2)
  end

  test 'shows as the name' do
    assert_equal 'Junior', Seniority.new(1).to_s
  end

  test 'it handles seniorities bellow the first' do
    seniority = Seniority.new(0).previous
    assert_equal 'None', seniority.to_s
    assert_equal -1, seniority.to_i
  end

end
