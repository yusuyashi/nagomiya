class ReservationDetail < ApplicationRecord
  # アソシエーション (もし他のモデルとの関連があれば)
  belongs_to :service_menu
  belongs_to :customer
  belongs_to :therapist
 

  # バリデーション
  validates :service_menu_id, :customer_id, :therapist_id, :unit_price, :subtotal, presence: true
  validates :visit_datetime, :customer_name, :course_name, presence: true

  # 他のモデルメソッドやスコープなど、必要に応じて追加
end
