class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :question_type
      t.string :content
      t.integer :state
      t.string :integer

      t.timestamps null: false
    end
  end
end
