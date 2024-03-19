class ServiceMenu < ApplicationRecord
   validates :course_name, :price_incl_tax, :description, presence: true
   has_one_attached :image
   has_many :reservations
   has_many :reservation_details
end
