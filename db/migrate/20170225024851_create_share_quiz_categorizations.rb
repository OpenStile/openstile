class CreateShareQuizCategorizations < ActiveRecord::Migration
  def change
    create_table :share_quiz_categorizations do |t|
      t.string :name
      t.string :result_url
      t.text :description
      t.jsonb :options
      t.references :share_quiz, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
