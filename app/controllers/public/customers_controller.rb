class Public::CustomersController < ApplicationController
  before_action :restrict_guest_user, only: [:show]  # マイページのアクション名を指定
  before_action :authenticate_customer!, except: [:confirmation]
  def show
    @customer = current_customer

  end

  def edit
    @customer = current_customer
  end

   def update
    @customer = current_customer

    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer), notice: "登録情報が更新されました。"
    else
      render :edit
    end
   end

  def confirmation
  end

 def withdrawal
  @customer = current_customer
  # ユーザーを論理削除（is_deletedをtrueに設定）
  @customer.update(is_deleted: true)

  reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to public_root_path

 end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

  def restrict_guest_user
    if current_customer&.guest?
      redirect_to public_root_path, alert: "ゲストユーザーはこのページへのアクセスが許可されていません"
    end
  end

end
