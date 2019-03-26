class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.integer :total_score, default: 0
      t.integer :user_id
      t.integer :test_id
      t.timestamps
    end
    add_index :solutions, [:user_id, :test_id]
  end
end
