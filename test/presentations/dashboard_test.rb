require 'test_helper'

class DashboardTest < ActiveSupport::TestCase

  def dashboard
    @dashboard ||= Dashboard.new hackers(:jorge)
  end

  test 'build a dashboard for a user' do
    dashboard
  end

  test 'have a title' do
    assert_equal 'Welcome Jorge', dashboard.title
  end

  test 'have a career' do
    assert_equal hackers(:jorge).career, dashboard.career
  end

end
