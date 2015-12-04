class HackerInviter

  attr_reader :hacker

  def initialize hacker
    @hacker = hacker
  end

  def give_seniority seniority
    Hacker.transaction do
      hacker.save
      hacker.acquirements.destroy_all
      add_acquirements seniority
    end
  end

  private

  def add_acquirements seniority
    skills_levels = hacker.career.requirements.
      where("seniority <= ?", seniority).group(:skill).maximum(:level)

    skills_levels.each do |skill, level|
      hacker.acquirements.create skill_id: skill.id, level: level
    end
  end
end
