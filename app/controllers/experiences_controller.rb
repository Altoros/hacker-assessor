class ExperiencesController < ApplicationController

  before_action :authorize_elders

  def create
    experience = Experience.new experience_params[:skill_id],
                                experience_params[:level]
    @acquirement = hacker.acquirements.find_or_initialize_by(
      skill: experience.skill
    )
    @acquirement.update_attributes experience: experience
    redirect_to hacker
  end

  private

  def hacker
    @hacker ||= Hacker.find params[:hacker_id]
  end

  def experience_params
    params.require(:experience).permit :skill_id, :level
  end

  def authorize_elders
    unless current_hacker.is_elder?
      redirect_to hacker, alert: 'Action not allowed'
    end
  end
end
