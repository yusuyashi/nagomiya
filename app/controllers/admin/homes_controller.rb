class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
  @reservation_details = ReservationDetail.all.page(params[:page])
  end


end
