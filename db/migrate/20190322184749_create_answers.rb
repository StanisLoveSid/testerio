class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.string :exact_answer
      t.integer :score, default: 0
      t.integer :position

      t.timestamps
    end
  end
end
