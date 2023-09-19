class AddDetailsToReservationDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :reservation_details, :visit_datetime, :datetime
    add_column :reservation_details, :customer_name, :string
    add_column :reservation_details, :course_name, :string
  end
end
