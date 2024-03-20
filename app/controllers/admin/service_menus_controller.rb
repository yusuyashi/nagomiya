class Admin::ServiceMenusController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_service_menu, only: [:show, :edit, :update]

  def index
    @service_menus = ServiceMenu.all.page(params[:page])
  end

  def new
    @service_menu = ServiceMenu.new
  end

  def create
    @service_menu = ServiceMenu.new(service_menu_params)
    if @service_menu.save
      redirect_to admin_service_menu_path(@service_menu), notice: 'Service menu was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @service_menu.update(service_menu_params)
      redirect_to admin_service_menu_path(@service_menu), notice: 'Service menu was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service_menu = ServiceMenu.find(params[:id])
    @service_menu.destroy
    redirect_to admin_service_menus_path, notice: '施術メニューが削除されました'
  end

  private

  def set_service_menu
    @service_menu = ServiceMenu.find(params[:id])
  end

  def service_menu_params
    params.require(:service_menu).permit(:course_name, :price_incl_tax, :description, :image)
  end

end