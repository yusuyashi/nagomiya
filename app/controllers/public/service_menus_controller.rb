class Public::ServiceMenusController < ApplicationController
  def index
    @service_menus = ServiceMenu.all.page(params[:page])
  end
end
