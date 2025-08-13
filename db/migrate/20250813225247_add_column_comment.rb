class AddColumnComment < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :some_info, :string, comment: Post.comment
  end
end
