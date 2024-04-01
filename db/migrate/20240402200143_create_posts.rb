class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts, force: true do |t|
      t.string :other_id
    end
  end
end
