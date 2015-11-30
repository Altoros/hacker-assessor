class AcquirementsController < ApplicationController
  before_action :set_acquirement, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @acquirements = current_hacker.acquirements
  end

  def new
    @acquirement = Acquirement.new
  end

  def edit
  end

  def create
    skill = acquirement_params.delete(:skill_id)
    @acquirement = Acquirement.find_or_initialize_by(
      skill_id: skill,
      hacker_id: acquirement_params.delete(:hacker_id)
    )
    @acquirement.update acquirement_params
    respond_with(@acquirement,
                 notice: "Now #{@acquirement.hacker.name} knows #{ @acquirement.skill.name }",
                 location: root_path)
  end

  def update
    @acquirement.update(acquirement_params)
    respond_with(@acquirement, location: acquirements_path)
  end

  def destroy
    @acquirement.destroy
    respond_with(@acquirement)
  end

  private

    def acquirements
      current_hacker.acquirements
    end

    def set_acquirement
      @acquirement = Acquirement.find(params[:id])
    end

    def acquirement_params
      params.require(:acquirement).permit(:level, :hacker_id, :skill_id)
    end
end
