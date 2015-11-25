class ExperiencesController < ApplicationController

  def create
    hacker = Hacker.find params[:hacker_id]
    experience = Experience.new experience_params[:skill_id],
                                experience_params[:level]
    @acquirement = hacker.acquirements.find_or_initialize_by(
      skill: experience.skill
    )
    @acquirement.update_attributes experience: experience
    redirect_to hacker
  end

  private

  def experience_params
    params.require(:experience).permit :skill_id, :level
  end
end
