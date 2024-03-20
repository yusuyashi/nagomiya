class Admin::ReservationsDetailsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @reservation_detail = ReservationDetail.find(params[:id])
  end

  def destroy
    @reservation_detail = ReservationDetail.find(params[:id])
    @reservation_detail.destroy
    redirect_to admin_root_path, notice: '予約詳細が削除されました。'
  end

end
