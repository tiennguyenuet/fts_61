class AddDeletedAtToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :deleted_at, :datetime
  end
end
