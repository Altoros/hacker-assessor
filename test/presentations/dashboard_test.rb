require 'test_helper'

class DashboardTest < ActiveSupport::TestCase
  test 'build the dashboard' do
    Dashboard.new(hackers(:jorge)).rows.each do |r|
      assert Skill.exists? name: r.first
      assert (r.last.include?(:tilde) || r.last.include?(:cross))
    end
  end

  test 'build dashboard for the last seniority level' do
    hacker = Hacker.create email:     'hero@hacker.com',
                           password:  'password',
                           name:      'hero',
                           career:    careers(:js),
                           seniority: 9

    Dashboard.new(hacker).rows.each do |r|
      assert Skill.exists? name: r.first
      assert (r.last.include?(:tilde) || r.last.include?(:cross))
    end
  end
end
