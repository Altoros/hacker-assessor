class HackerInviter
  def initialize params
    @hacker = Hacker.new(params.except :seniority)
    @hacker.save
    add_acquirements params[:seniority]
  end

  def hacker
    @hacker
  end

  def add_acquirements seniority
    skills_levels = hacker.career.requirements.
      where("seniority <= ?", seniority).group(:skill).maximum(:level)

    skills_levels.each do |skill, level|
      hacker.acquirements.create skill_id: skill.id, level: level
    end
  end
end
