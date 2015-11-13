class Dashboard
  def initialize hacker
    @hacker = hacker
  end

  def rows
    requirements.map do |requirement|
      almost_empty_array = []
      almost_empty_array[requirement.level.to_i] = check_mark(requirement)
      [requirement.skill.name, almost_empty_array]
    end
  end

  private

  def requirements
    @hacker.career.requirements.where(seniority: 0..@hacker.seniority.next.to_i).
      group(:skill_id).select(:skill_id, 'MAX(level) AS level')
  end

  def check_mark requirement
    if @hacker.experience(requirement.skill) >= requirement.experience
      :tilde
    else
      :cross
    end
  end
end
