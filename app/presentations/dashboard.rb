class Dashboard

  class MatchingRequirement < Requirement
    def current
      @current ||= Experience.new skill_id, current_level
    end

    def required
      @required ||= Experience.new skill_id, level
    end
  end

  attr_reader :hacker

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

  def missing_requirements
    matching_requirements.where('acquirements.level < requirements.level OR
                                 acquirements.level IS NULL').
      where(seniority: current_seniority.next)
  end

  def editable?
    @reviewer.is_elder?
  end

  private

  def current_seniority
    @current_seniority ||= @hacker.seniority
  end

  def matching_requirements
    MatchingRequirement.
      where(career: career).
      includes(:skill).
      select('requirements.*', 'acquirements.level AS current_level').
      joins <<-SQL.strip_heredoc
      LEFT JOIN acquirements ON
                acquirements.skill_id = requirements.skill_id AND
                acquirements.hacker_id = #{ @hacker.id }
      SQL
  end

end
