class CreateCourseTimes < ActiveRecord::Migration
  def change
    create_table :course_times do |t|
      t.string :starts_at
      t.string :ends_at

      t.timestamps
    end
  end
end
