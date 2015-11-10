class Hacker < ActiveRecord::Base
  has_secure_password
  has_many :acquirements
  has_many :skills, through: :acquirements
  belongs_to :career

  validates :career_id, presence: true, unless: :admin
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def missing_requirements_for_next_seniority
    career.missing_requirements(acquirements).keep_if do |r|
      r.seniority == seniority.next
    end
  end

  def experience skill
    acquirements.find_or_initialize_by(skill: skill).experience
  end

  def seniority
    Seniority.new(super)
  end
end
