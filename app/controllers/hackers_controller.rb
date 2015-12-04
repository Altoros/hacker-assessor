class HackersController < ApplicationController
  before_action :set_hacker, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @hackers = Hacker.all
    respond_with(@hackers)
  end

  def show
    respond_with(@hacker)
  end

  def new
    @hacker = Hacker.new
    respond_with(@hacker)
  end

  def edit
  end

  def create
    @hacker = Hacker.new hacker_params
    HackerInviter.new(@hacker).give_seniority params[:hacker][:seniority]
    respond_with(@hacker)
  end

  def update
    @hacker.update(hacker_params)
    respond_with(@hacker)
  end

  def destroy
    @hacker.destroy
    respond_with(@hacker)
  end

  private
    def set_hacker
      @hacker = Hacker.find(params[:id])
    end

    def hacker_params
      params.require(:hacker).permit(:name, :email, :career_id, :password,
                                     :password_confirmation)
    end
end
