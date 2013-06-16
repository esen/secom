class ChangesToAttendances < ActiveRecord::Migration
  def up
    add_column :courses, :dates, :text
    remove_column :attendances, :branch_id
    change_column :attendances, :attended, :boolean
  end

  def down
    remove_column :courses, :dates
    add_column :attendances, :branch_id, :integer
  end
end
