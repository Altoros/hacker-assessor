class WelcomeController < ApplicationController
  skip_before_action :require_authentication

  def index
    case current_role
    when 'admin'
      redirect_to hackers_path
    when 'hacker'
      @hacker = current_hacker
      @dashboard = Dashboard.new(@hacker)
      render 'hackers/show'
    end
  end
end
