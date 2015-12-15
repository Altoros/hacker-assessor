class Dashboard

  def initialize hacker, reviewer: hacker
    raise ArgumentError unless hacker
    @hacker = hacker
    @reviewer = reviewer
  end

  def title
    "Welcome #{ @hacker.name.titleize }"
  end

  def career
    @career ||= @hacker.career
  end

  def seniority_detail
    "#{ current_seniority } => #{ current_seniority.next }"
  end

  def matching_requirements
    missing_requirements.map do |requirement|
      MatchingRequirement.new @hacker.experience(requirement.skill),
                              requirement.experience
    end
  end

  def editable?
    @reviewer.is_elder?
  end

  private

  def current_seniority
    @current_seniority ||= @hacker.seniority
  end

  def missing_requirements
    @missing_requirements ||= @hacker.career.missing_requirements(@hacker.acquirements).keep_if do |r|
      r.seniority == current_seniority.next
    end
  end

  MatchingRequirement = Struct.new :current, :required do
    def skill_name
      required.skill.name
    end
  end

end
