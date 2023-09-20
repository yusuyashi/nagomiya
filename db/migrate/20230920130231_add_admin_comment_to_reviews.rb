class AddAdminCommentToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :admin_comment, :string
  end
end
