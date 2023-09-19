class Public::ReservationsController < ApplicationController

  def new
    @service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation = Reservation.new
  end
  
  def create
  @service_menu = ServiceMenu.find(params[:reservation][:service_menu_id])
  @reservation = Reservation.new(reservation_params)
  @reservation.total_amount = @service_menu.price_incl_tax

  if @reservation.save
    redirect_to confirm_public_reservation_path(@reservation)
  else
    render :new
  end
  end



  def confirm
  @reservation = Reservation.find(params[:id])
  @customer = @reservation.customer
  end
  
  



  def complete
   
  end
  
def update
  @reservation = Reservation.find(params[:id])
  @customer = @reservation.customer
  if @customer.update(customer_params)
    redirect_to confirm_public_reservation_path(@reservation)
  else
    render :confirm
  end
end

private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :postal_code, :address, :telephone_number, :email)
end

end


 

 

