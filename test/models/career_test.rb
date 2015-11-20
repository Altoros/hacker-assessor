require 'test_helper'

class CareerTest < ActiveSupport::TestCase
  test "have a seniority" do
    assert_equal 2, careers(:js).get_seniority(hackers(:jorge).acquirements)
  end

  test "Once you know everything you are a hero" do
    hackers(:jorge).acquirements.update_all level: 5
    hackers(:jorge).acquirements.create! skill: skills(:ruby),
                                        level: 5
    great_acquirements = hackers(:jorge).acquirements(true)
    assert_equal 'Hero', careers(:js).get_seniority(great_acquirements).to_s
  end
end
