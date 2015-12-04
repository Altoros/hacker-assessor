class CareersController < ApplicationController
  before_action :set_career, only: [:show, :edit, :update, :destroy, :panorama]

  respond_to :html

  def index
    @careers = Career.all
    respond_with(@careers)
  end

  def show
    respond_with(@career)
  end

  def new
    @career = Career.new
    respond_with(@career)
  end

  def edit
  end

  def create
    @career = Career.new career_params
    bulk_import_requirements or @career.save
    respond_with(@career)
  end

  def update
    @career.update_attributes career_params
    bulk_import_requirements
    respond_with(@career)
  end

  def destroy
    @career.destroy
    respond_with(@career)
  end

  def panorama
    @panorama = Panorama.new @career
    respond_with(@panorama)
  end

  private
    def set_career
      @career = Career.find(params[:id])
    end

    def career_params
      params.require(:career).permit(:name, :description)
    end

    def bulk_import_requirements
      requirements = params[:career][:requirements].try(:tempfile)
      BulkCareerImporter.new(@career).import(requirements) if requirements.present?
    end

end
