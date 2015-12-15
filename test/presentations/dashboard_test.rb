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
    matching_requirements = dashboard.matching_requirements
    assert matching_requirements
    assert matching_requirements.first.required
    assert matching_requirements.first.skill_name
    assert matching_requirements.first.current
  end

  test 'elder hackers can edit the dashboard' do
    refute dashboard.editable?
    assert Dashboard.new(hackers(:jorge), reviewer: hackers(:leo)).editable?,
      'Leo can edit'
  end

end
