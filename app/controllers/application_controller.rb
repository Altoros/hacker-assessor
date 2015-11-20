class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_authentication
  helper_method :current_hacker

  private

    def require_authentication
      redirect_to root_url, alert: 'Login required' unless session[:hacker_id]
    end

    def current_hacker
      @current_hacker ||= Hacker.find session[:hacker_id] if session[:hacker_id]
    end
end
