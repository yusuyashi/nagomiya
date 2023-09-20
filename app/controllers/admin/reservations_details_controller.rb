class Admin::ReservationsDetailsController < ApplicationController
  def show
    @reservation_detail = ReservationDetail.find(params[:id])
  end
end
