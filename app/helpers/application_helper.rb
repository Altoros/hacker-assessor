module ApplicationHelper
  def md5 string
    Digest::MD5.hexdigest string
  end

  def assign_class requirement, acquirement
    if acquirement.level != 'none' && requirement - acquirement == 1
      "almost-accomplished"
    else
      "not-accomplished"
    end
  end

  def gravatar_url hacker
    'http://www.gravatar.com/avatar/' + md5(hacker.email)
  end

  def current_hacker_gravatar
    image_tag(gravatar_url(current_hacker), class: 'avatar')
  end
end
