class AddIsGuestToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_guest, :boolean
  end
end
