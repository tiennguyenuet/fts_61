class AddColumnsToExamination < ActiveRecord::Migration
  def change
    add_column :examinations, :time_start, :integer
    add_column :examinations, :time_end, :integer
  end
end
