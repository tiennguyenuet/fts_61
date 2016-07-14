class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :description
      t.integer :total_question
      t.integer :duration

      t.timestamps null: false
    end
  end
end
