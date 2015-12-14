class Dashboard

  def initialize hacker, *_
    raise ArgumentError, "hacker is not there: #{ hacker.inspect }" unless hacker
    @hacker = hacker
  end

  def title
    "Welcome #{ @hacker.name.titleize }"
  end

  def career
    @career ||= @hacker.career
  end

end
