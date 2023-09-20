class ServiceMenu < ApplicationRecord
   has_one_attached :image
   has_many :reservations
   has_many :reservation_details
end
