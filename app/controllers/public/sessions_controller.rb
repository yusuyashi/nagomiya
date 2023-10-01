# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    root_path #topページにリダイレクト
  end


  def guest_sign_in
    customer = Customer.guest
    customer.reset_guest_attributes  # ここでゲスト情報をデフォルトに戻す
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.is_deleted
      sign_out(resource)
      flash[:alert] = 'このアカウントは退会済みです。'
      redirect_to new_customer_session_path
    else
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
