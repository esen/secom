class AddBranchIdToAll < ActiveRecord::Migration
  def change
    add_column :course_times, :branch_id, :integer
    add_column :expenses, :branch_id, :integer
    add_column :groups, :branch_id, :integer
    add_column :holes, :branch_id, :integer
    add_column :lessons, :branch_id, :integer
    add_column :levels, :branch_id, :integer
    add_column :ort_cheques, :branch_id, :integer
    add_column :ort_exam_types, :branch_id, :integer
    add_column :ort_exams, :branch_id, :integer
    add_column :ort_participants, :branch_id, :integer
    add_column :payment_dates, :branch_id, :integer
    add_column :payments, :branch_id, :integer
    add_column :rooms, :branch_id, :integer
    add_column :sources, :branch_id, :integer
    add_column :students, :branch_id, :integer
    add_column :teachers, :branch_id, :integer
    add_column :users, :branch_id, :integer
  end
end
