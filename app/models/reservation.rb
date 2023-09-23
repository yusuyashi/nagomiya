class Reservation < ApplicationRecord
  belongs_to :service_menu
  belongs_to :therapist, optional: true  # optional: true を追加
  belongs_to :customer
end
