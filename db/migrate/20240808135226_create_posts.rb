class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :text, limit: 100
      t.belongs_to :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
