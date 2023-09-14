class Public::ReservationsController < ApplicationController
    
  def new
    @service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation = Reservation.new(service_menu: @service_menu)
  end

  def create
    @service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.service_menu = @service_menu
    @reservation.customer = current_customer # current_customerはログインしている顧客を参照するメソッドと仮定
    if @reservation.save
      redirect_to confirm_public_reservations_path
    else
      render :new
    end
  end
  
  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.service_menu = ServiceMenu.find(params[:service_menu_id])
    @reservation.customer = current_customer
  
    if @reservation.valid?
      session[:reservation_data] = @reservation.attributes
    else
      render :new
    end
  end


  def complete
  @reservation = Reservation.new(session[:reservation_data])
  
    if @reservation.save
        session.delete(:reservation_data)
    # ここで任意の完了メッセージを表示することもできます。
      redirect_to your_success_path, notice: "予約が完了しました"
    else
    render :new
    end
    
  end

  
  private

  def reservation_params
    params.require(:reservation).permit(:therapist_id, :visit_datetime, :service_menu_id)
  end

end

 

 

