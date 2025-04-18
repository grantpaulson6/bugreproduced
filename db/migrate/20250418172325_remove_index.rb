class RemoveIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :posts, column: [:other_id]
  end
end
