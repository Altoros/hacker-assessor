class Requirement < ActiveRecord::Base
  belongs_to :career
  belongs_to :skill
  composed_of :experience, mapping: [['skill_id'], ['level', 'level_id']]

  validates :level, presence: true
  validates :skill_id, presence: true,
                       uniqueness: { scope: [:seniority, :career] }

  def seniority
    Seniority.new(super)
  end

  def inspect full = false
    return super if full
    "#<Requirement##{ id }, experience: #{ experience.inspect }," +
      " seniority: #{ seniority }, career_id: #{ career.name }>"
  rescue
    super
  end
end
