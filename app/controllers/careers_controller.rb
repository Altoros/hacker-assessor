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
    @career = build_bulk_importer
    respond_with(@career)
  end

  def update
    @career = build_bulk_importer
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
      params.require(:career).permit(:name, :description, :requirements)
    end

    def build_bulk_importer
      BulkCareerImporter.new career_params[:name],
        career_params[:requirements].try(:tempfile),
        career_params[:description]
    end
end
