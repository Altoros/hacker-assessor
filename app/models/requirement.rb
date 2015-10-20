require 'experience_level'

class Requirement < ActiveRecord::Base
  belongs_to :career
  belongs_to :skill

  validates :level, presence: true
  validates :skill_id, presence: true,
                       uniqueness: { scope: [:seniority, :career] }

  def level
    ExperienceLevel.new(super)
  end

  def seniority
    Seniority.new(super)
  end
end
