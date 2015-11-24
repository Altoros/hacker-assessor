class Hacker < ActiveRecord::Base
  has_secure_password
  has_many :acquirements
  has_many :skills, through: :acquirements
  belongs_to :career

  validates :career_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def seniority
    career.get_seniority acquirements unless id.nil?
  end

  def missing_requirements_for_next_seniority
    career.missing_requirements(acquirements).keep_if do |r|
      r.seniority == seniority.next
    end
  end

  def experience skill
    acquirement = acquirements.where(skill: skill).first
    level = acquirement ? acquirement.level : 0
    Experience.new skill.id, level
  end
end
