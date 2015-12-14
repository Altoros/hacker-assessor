require 'test_helper'

class DashboardTest < ActiveSupport::TestCase

  def dashboard
    @dashboard ||= Dashboard.new hackers(:jorge)
  end

  test 'have a title' do
    assert_equal 'Welcome Jorge', dashboard.title
  end

  test 'have a career' do
    assert_equal hackers(:jorge).career, dashboard.career
  end

  test 'show the seniority detail' do
    assert_equal 'Junior+ => Semi-Senior', dashboard.seniority_detail
  end

  test 'shows matching requirements' do
    assert dashboard.matching_requirements
  end

end
