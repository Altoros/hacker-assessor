class AcquirementsController < ApplicationController
  before_action :set_acquirement, only: [:edit, :update, :destroy]

  # GET /acquirements
  # GET /acquirements.json
  def index
    @acquirements = current_hacker.acquirements
  end

  # GET /acquirements/new
  def new
    @acquirement = acquirements.new
  end

  # GET /acquirements/1/edit
  def edit
  end

  # POST /acquirements
  # POST /acquirements.json
  def create
    @acquirement = current_hacker.acquirements.create acquirement_params

    respond_to do |format|
      if @acquirement.save
        format.html { redirect_to new_acquirement_path, notice: 'Acquirement was successfully created.' }
        format.json { render :show, status: :created, location: @acquirement }
      else
        format.html { render :new }
        format.json { render json: @acquirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acquirements/1
  # PATCH/PUT /acquirements/1.json
  def update
    respond_to do |format|
      if @acquirement.update(acquirement_params)
        format.html { redirect_to acquirements_path, notice: 'Acquirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @acquirement }
      else
        format.html { render :edit }
        format.json { render json: @acquirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acquirements/1
  # DELETE /acquirements/1.json
  def destroy
    @acquirement.destroy
    respond_to do |format|
      format.html { redirect_to acquirements_url, notice: 'Acquirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def acquirements
      current_hacker.acquirements
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_acquirement
      @acquirement = acquirements.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acquirement_params
      params.require(:acquirement).permit(:level, :hacker_id, :skill_id)
    end
end
