class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :service_menu_id, null: false
      t.integer :customer_id, null: false
      t.integer :therapist_id, null: false
      t.datetime :visit_datetime, null: false
      t.integer :total_amount, null: false

      t.timestamps
    end
  end
end
