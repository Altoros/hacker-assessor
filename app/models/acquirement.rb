class Acquirement < ActiveRecord::Base
  belongs_to :hacker
  belongs_to :skill
  composed_of :experience, mapping: [['skill_id', 'skill_id'], ['level', 'level_id']]

  validates :level, presence: true
  validates :skill_id, presence: true, uniqueness: { scope: :hacker_id }
end
