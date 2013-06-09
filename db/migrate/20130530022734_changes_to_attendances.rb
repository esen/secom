class ChangesToAttendances < ActiveRecord::Migration
  def up
    add_column :courses, :dates, :text
    remove_column :attendances, :checks
    remove_column :attendances, :branch_id
    add_column :attendances, :attended, :boolean
  end

  def down
    remove_column :courses, :dates
    add_column :attendances, :checks, :text
    add_column :attendances, :branch_id, :integer
    remove_column :attendances, :attended
  end
end
