class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.integer :total_score, default: 0
      t.belongs_to :solutionable, polymorphic: true
      t.timestamps
    end
    add_index :solutions, [:solutionable_id, :solutionable_type]
  end
end
