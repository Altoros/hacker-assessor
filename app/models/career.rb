class Career < ActiveRecord::Base
  has_many :hackers
  has_many :requirements

  validates :name, presence: true, uniqueness: true

  def get_seniority acquirements
    missing_requirements(acquirements).map(&:seniority).min.previous
  end

  def missing_requirements acquirements
    requirements.reject do |requirement|
      acquirements.any? do |acquirement|
        requirement.skill_id == acquirement.skill_id && acquirement.level >= requirement.level
      end
    end
  end
end
