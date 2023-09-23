class RemoveNotNullConstraintFromTherapistIdInReservationDetails < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reservation_details, :therapist_id, true
  end
end
