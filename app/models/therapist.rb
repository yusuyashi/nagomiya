class Therapist < ApplicationRecord
  has_one_attached :image
  has_many :reservations
end
