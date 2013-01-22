class AddStartDateToExam < ActiveRecord::Migration
  def up
    add_column :ort_exams, :start_date, :date
  end

  def down
    remove_column :ort_exams, :start_date
  end
end
