class Therapist < ApplicationRecord
  validates :therapist_name, :experience_years, :introduction, presence: true
  has_one_attached :image
  has_many :reservations
  has_many :reservation_details
end
