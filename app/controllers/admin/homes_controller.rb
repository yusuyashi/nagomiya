class Admin::HomesController < ApplicationController
  def top
  @reservation_details = ReservationDetail.all.page(params[:page])
  end
  

end
