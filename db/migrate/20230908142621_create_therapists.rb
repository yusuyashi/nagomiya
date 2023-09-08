class CreateTherapists < ActiveRecord::Migration[6.1]
  def change
    create_table :therapists do |t|
      t.string :therapist_name, null: false
      t.integer :experience_years, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
