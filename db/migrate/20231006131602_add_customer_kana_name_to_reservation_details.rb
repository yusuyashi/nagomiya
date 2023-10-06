class AddCustomerKanaNameToReservationDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :reservation_details, :customer_kana_name, :string
  end
end
