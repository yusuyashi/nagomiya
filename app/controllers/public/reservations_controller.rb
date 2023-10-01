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
  @reservation = Reservation.find(params[:id])
  @customer = @reservation.customer
  @service_menu = @reservation.service_menu

  # @customerが有効でない場合は、確定を中止し、再度確認画面を表示する
  unless @customer.valid?
    flash[:alert] = "顧客情報が正しくありません。"
    render :confirm
    return
  end

  # 以下は以前のコードを維持
  @reservation_detail = ReservationDetail.new(
    service_menu_id: @service_menu.id,
    customer_id: @customer.id,
    therapist_id: @reservation.therapist_id,
    unit_price: @service_menu.price_incl_tax,
    subtotal: @reservation.total_amount,
    visit_datetime: @reservation.visit_datetime,
    customer_name: "#{@customer.last_name} #{@customer.first_name}",
    course_name: @service_menu.course_name,
    created_at: Time.now,
    updated_at: Time.now
  )

 

  if @reservation_detail.save
    redirect_to thanks_public_reservation_path(@reservation), notice: "Reservation completed successfully!"
  else
    flash[:alert] = "There was an error completing the reservation."
    render :confirm
  end

  end



  def thanks
    @reservation = Reservation.find(params[:id])
    # お礼メッセージや、予約の詳細情報などを表示するためのロジックをここに記述
  end



def update
  @reservation = Reservation.find(params[:id])
  @customer = @reservation.customer

  if @customer.guest?
    # ゲストユーザーの場合、情報をアップデートする
    if @customer.update(customer_params)
      flash[:notice] = "ゲストユーザーの情報を更新しました。"
      redirect_to confirm_public_reservation_path(@reservation)
    else
      flash[:alert] = "情報の更新に失敗しました。"
      render :confirm
    end
  else
    # 通常のユーザーの場合、情報をアップデートする
    if @customer.update(customer_params)
      redirect_to confirm_public_reservation_path(@reservation)
    else
      render :confirm
    end
  end
end


private

def reservation_params
  params.require(:reservation).permit(:service_menu_id, :customer_id, :therapist_id, :visit_datetime)
end

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :postal_code, :address, :telephone_number, :email)
end

end






