class CreateReservationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_details do |t|
      t.integer :service_menu_id, null: false
      t.integer :customer_id, null: false
      t.integer :therapist_id, null: false
      t.integer :unit_price, null: false
      t.integer :subtotal, null: false

      t.timestamps
    end
  end
end
