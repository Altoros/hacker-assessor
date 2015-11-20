class WelcomeController < ApplicationController
  skip_before_action :require_authentication

  def index
    if current_hacker
      @hacker = current_hacker
      render 'hackers/show'
    end
  end
end
