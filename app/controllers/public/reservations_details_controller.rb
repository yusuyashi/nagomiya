class Public::ReservationsDetailsController < ApplicationController
  before_action :set_reservation_detail, only: [:show]

  # GET /reservations_details
  def index
    @reservation_details = ReservationDetail.all
  end

  # GET /reservations_details/:id
  def show
  end
  
  def destroy
    @reservation_detail = ReservationDetail.find(params[:id])
    @reservation_detail.destroy

    redirect_to public_reservations_details_path, notice: 'Reservation detail was successfully deleted.'
  end

  private

  def set_reservation_detail
    @reservation_detail = ReservationDetail.find(params[:id])
  end
end
