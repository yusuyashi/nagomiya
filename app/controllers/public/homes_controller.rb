class Public::HomesController < ApplicationController
  def top
    @service_menus = ServiceMenu.all # ここで @service_menus インスタンス変数を設定
  end
end
