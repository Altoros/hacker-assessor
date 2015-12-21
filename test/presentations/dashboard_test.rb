require 'test_helper'

class DashboardTest < ActiveSupport::TestCase

  def dashboard hacker = hackers(:jorge)
    @dashboard ||= Dashboard.new hacker
  end

  def experience level: 3, skill: skills(:tdd)
    Experience.new skill, level
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

  test 'shows missing requirements' do
    missing_requirements = dashboard.missing_requirements 
    assert missing_requirements 
    tdd_requirement = missing_requirements.where(skill: skills(:tdd)).first
    assert_equal experience, tdd_requirement.required
    assert_equal 'tdd', tdd_requirement.skill.name
    assert_equal experience(level: 2), tdd_requirement.current
    assert_equal 1, missing_requirements.size
  end

  test 'find all the missign requirements' do
    assert_equal 2, dashboard(hackers(:rodrigo)).missing_requirements.size
  end

  test 'elder hackers can edit the dashboard' do
    refute dashboard.editable?
    assert Dashboard.new(hackers(:jorge), reviewer: hackers(:leo)).editable?,
      'Leo can edit'
  end

  test 'have a hacker' do
    assert_equal hackers(:jorge), dashboard.hacker
  end

end
