class Public::ReservationsDetailsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_reservation_detail, only: [:show, :destroy]

  # GET /reservations_details
  def index
    @reservation_details = current_customer.reservation_details.page(params[:page])
  end

  # GET /reservations_details/:id
  def show
    unless @reservation_detail.customer == current_customer
      flash[:error] = "You are not authorized to view this reservation detail."
      redirect_to root_path
    end
  end

  private

  def set_reservation_detail
    @reservation_detail = ReservationDetail.find(params[:id])
  end
end

