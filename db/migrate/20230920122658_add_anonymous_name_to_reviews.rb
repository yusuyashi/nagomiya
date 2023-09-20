class AddAnonymousNameToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :anonymous_name, :string
  end
end
