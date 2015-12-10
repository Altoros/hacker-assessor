class Career < ActiveRecord::Base
  has_many :hackers, dependent: :restrict_with_error
  has_many :requirements

  validates :name, presence: true, uniqueness: true

  # Get the current seniority for a given set of requirements.
  #
  # Handle specialy the case of knowing everything required for all levels.
  def get_seniority acquirements
    missing_requirements = missing_requirements(acquirements)
    return Seniority.new(Seniority::NAMES.size - 1) if missing_requirements.empty?
    missing_requirements.map(&:seniority).min.previous
  end

  def missing_requirements acquirements
    requirements.reject do |requirement|
      acquirements.any? do |acquirement|
        requirement.skill_id == acquirement.skill_id && acquirement.level >= requirement.level
      end
    end
  end
end
