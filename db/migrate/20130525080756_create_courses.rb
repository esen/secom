class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :group_id
      t.integer :lesson_id
      t.integer :course_time_id
      t.integer :teacher_id
      t.integer :room_id
      t.integer :branch_id
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday

      t.timestamps
    end
  end
end
