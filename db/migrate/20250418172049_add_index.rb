class AddIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, :other_id
  end
end
