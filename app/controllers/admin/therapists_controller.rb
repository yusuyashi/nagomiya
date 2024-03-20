class Admin::TherapistsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @therapists = Therapist.all
  end

  def new
    @therapist = Therapist.new
  end

  def create
    @therapist = Therapist.new(therapist_params)
    if @therapist.save
      redirect_to admin_therapist_path(@therapist)
    else
      render :new
    end
  end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def edit
    @therapist = Therapist.find(params[:id])
  end

  def update
    @therapist = Therapist.find(params[:id])
    if @therapist.update(therapist_params)
      redirect_to admin_therapist_path(@therapist)
    else
      render :edit
    end
  end

  def destroy
    @therapist = Therapist.find(params[:id])
    @therapist.destroy
    redirect_to admin_therapists_path, notice: 'Therapist was successfully destroyed.'
  end


  private

  def therapist_params
    params.require(:therapist).permit(:therapist_name, :experience_years, :introduction, :image )
  end

end

