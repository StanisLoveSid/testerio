class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.references :test, foreign_key: true
      t.integer :total_score, default: 0

      t.timestamps
    end
  end
end
