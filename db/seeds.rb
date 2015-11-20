# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# Our test user is a Semi Senior JS
TEST_USER_ACQUIREMENTS = {
  "TDD"    => 1,
  "JS"     => 3,
  "NodeJS" => 2,
  "JSON"   => 3,
  "jQuery" => 3
}

%w[ applies_to_all_areas.csv devops.csv front_end.csv non_mesurable.csv
    ruby.csv ].each do |f|
  CSV.open Rails.root.join('db', 'seeds', f), headers: true do |t|
    t.each do |s|
      skill = Skill.find_or_create_by! name: s[0] if s[0]
      Rails.logger.info { skill.inspect }
    end
  end
end

career = Career.find_or_create_by! name: 'Javascript' do |c|
  c.description = 'Javascript developers start with jQuery, then they use node.'
end

# Lets make tests simplier
Hacker.find_or_create_by! email: 'test@hacker.com' do |hacker|
  hacker.password = 'password'
  hacker.name = 'Test'
  hacker.career = career
end if Hacker.all.empty? || Rails.env.development? || Rails.env.test?

hacker = Hacker.find_by email: 'test@hacker.com'
if hacker
  TEST_USER_ACQUIREMENTS.map do |s, l|
    acquirement = hacker.acquirements.create_with(level: l).
      find_or_create_by! skill: Skill.find_by(name: s)
    Rails.logger.info { acquirement.inspect }
  end
end

[
  { skill: 'TDD', seniority: 2, level: 2 },
  { skill: 'TDD', seniority: 3, level: 3 },
  { skill: 'JS', seniority: 2, level: 2 },
  { skill: 'JS', seniority: 3, level: 3 }
].each do |requirement|
  requirement = career.requirements.find_or_create_by!(
    skill: Skill.find_by!(name: requirement[:skill]),
    seniority: requirement[:seniority],
    level: requirement[:level]
  )
  Rails.logger.info { requirement.inspect }
end
