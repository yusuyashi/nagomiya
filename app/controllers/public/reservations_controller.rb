class Public::ReservationsController < ApplicationController
    
  def new
    @service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation = Reservation.new(service_menu: @service_menu)
  end

  def create
  @service_menu = ServiceMenu.find(params[:service_menu_id])
  @reservation = Reservation.new(reservation_params)
  @reservation.service_menu = @service_menu
  @reservation.customer = current_customer
  @reservation.total_amount = @service_menu.price_incl_tax

  if @reservation.save
    session[:reservation_data] = @reservation.attributes
    redirect_to confirm_public_service_menu_reservations_path(service_menu_id: @service_menu.id)
  else
    render :new
  end
  end

  def confirm
  Rails.logger.debug("Session Data: #{session[:reservation_data].inspect}")
  
    @service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation = Reservation.new(session[:reservation_data])
    @reservation.service_menu = @service_menu
    @reservation.customer = current_customer
    @reservation.therapist_id = session[:reservation_data]["therapist_id"]

    if @reservation.valid?
      session[:reservation_data] = @reservation.attributes
    else
      Rails.logger.debug(@reservation.errors.full_messages.join("\n"))
      render :new
    end
  end

  def complete
  
  end



  private

  def reservation_params
    params.require(:reservation).permit(:therapist_id, :visit_datetime, :service_menu_id)
  end

end

 

 

