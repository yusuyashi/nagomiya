class Reservation < ApplicationRecord
  
  belongs_to :service_menu
  belongs_to :therapist, optional: true  # optional: true を追加
  belongs_to :customer
  
  validate :visit_datetime_in_future, on: :create

  private

  def visit_datetime_in_future
    errors.add(:visit_datetime, "過去の日時では予約できません。") if visit_datetime.present? && visit_datetime < DateTime.now
  end
  
end
