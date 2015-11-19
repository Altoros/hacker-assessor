require 'test_helper'

class CareerTest < ActiveSupport::TestCase
  test "have a seniority" do
    assert_equal 2, careers(:js).get_seniority(hackers(:jorge).acquirements)
  end
end
