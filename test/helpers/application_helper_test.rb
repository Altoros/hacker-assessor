require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'assign_class method' do
    assert_equal 'not-accomplished', assign_class(experience(1), experience(0))
    assert_equal 'not-accomplished', assign_class(experience(3), experience(1))
    assert_equal 'almost-accomplished', assign_class(experience(3), experience(2))
  end

  def experience level
    Experience.new(skills(:tdd), level)
  end

end
