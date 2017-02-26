class CreateShareQuizzes < ActiveRecord::Migration
  def change
    create_table :share_quizzes do |t|
      t.string :name
      t.text :description
      t.integer :completions
      t.integer :shares

      t.timestamps null: false
    end
  end
end
