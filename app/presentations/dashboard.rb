class Dashboard

  def initialize hacker, *_
    raise ArgumentError unless hacker
    @hacker = hacker
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
    []
  end

  private

  def current_seniority
    @current_seniority ||= @hacker.seniority
  end

end
