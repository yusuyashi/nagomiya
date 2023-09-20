class Admin::HomesController < ApplicationController
  def top
  @reservation_details = ReservationDetail.all
  end

end
