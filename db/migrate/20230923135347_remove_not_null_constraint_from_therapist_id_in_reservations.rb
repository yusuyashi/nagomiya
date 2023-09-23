class RemoveNotNullConstraintFromTherapistIdInReservations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reservations, :therapist_id, true
  end
end
