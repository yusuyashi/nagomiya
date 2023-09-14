class CreateServiceMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :service_menus do |t|
      t.string :course_name, null: false
      t.integer :price_incl_tax, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
