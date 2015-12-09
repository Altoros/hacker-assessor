require 'csv'

class BulkCareerImporter

  ENFORCED_HEADERS = %w[ skill apprentice junior junior+ semi-senior
                         semi-senior+ senior senior+ lead architect
                         hero ]

  attr_reader :career

  def initialize career
    @career = career
  end

  def import requirements
    Career.transaction do
      raise ActiveRecord::Rollback unless career.save
      career.requirements.destroy_all
      process_csv requirements
    end
  end

  private

  def process_csv requirements
    data = CSV.new requirements, headers: true, header_converters: :downcase
    data = data.read
    check_headers data
    data.each do |skill_requirements|
      build_requirements find_skill(skill_requirements['skill']),
        skill_requirements.fields(1..-1)
    end
  rescue Encoding::UndefinedConversionError
    career.errors.add(:requirements, 'file have invalid characters')
    raise ActiveRecord::Rollback
  end

  def check_headers data
    unless data.headers == ENFORCED_HEADERS
      career.errors.add :requirements, 'headers do not match'
      raise ActiveRecord::Rollback, 'invalid headers'
    end
  end

  def find_skill skill_name
    Skill.find_by 'lower(name) = ?', skill_name.downcase or
      Skill.create name: skill_name
  end

  # skill is an Skill object that already exists in the DB.
  # requirements is an array that represents the level for each Seniority.
  # i.e.
  # requirements = ["2", "2", "2", "2", "3", "3", "3", "3", "3", "3"]
  # The index of the requirements match with the index of the array
  # in Seniority::NAMES because the index of the requirements match
  # with the columns in the csv.
  # Then the number in the requirements match with a level for each skill
  # and each seniority.
  def build_requirements skill, requirements
    requirements.zip(Seniority::NAMES)
      .chunk{ |v, s| v.to_i unless v.nil? || v.to_i <= 0 }
      .map do |exp, seniorities|
        seniority = Seniority::NAMES.index seniorities.first.last
        career.requirements.create! seniority: seniority,
                                    level: exp,
                                    skill: skill
    end
  end

end
