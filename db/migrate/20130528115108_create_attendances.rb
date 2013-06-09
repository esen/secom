class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :branch_id
      t.integer :student_id
      t.integer :course_id
      t.text :attended
      t.float :percentage

      t.timestamps
    end
  end
end
