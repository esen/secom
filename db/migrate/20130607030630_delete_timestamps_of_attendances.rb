class DeleteTimestampsOfAttendances < ActiveRecord::Migration
  def up
    remove_column :attendances, :created_at
    remove_column :attendances, :updated_at
    remove_column :attendances, :percentage
    add_column :attendances, :checked_at, :date
  end

  def down
    remove_column :attendances, :checked_at
  end
end
