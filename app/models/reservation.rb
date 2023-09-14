class Reservation < ApplicationRecord
  belongs_to :service_menu
  belongs_to :therapist
  belongs_to :customer
end
