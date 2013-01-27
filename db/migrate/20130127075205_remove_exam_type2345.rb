class RemoveExamType2345 < ActiveRecord::Migration
  def up
    rename_column :ort_exams, :exam_type1_id, :exam_type_id
    rename_column :ort_cheques, :mark1, :mark
    remove_column :ort_exams, :exam_type2_id
    remove_column :ort_exams, :exam_type3_id
    remove_column :ort_exams, :exam_type4_id
    remove_column :ort_exams, :exam_type5_id
    remove_column :ort_cheques, :mark2
    remove_column :ort_cheques, :mark3
    remove_column :ort_cheques, :mark4
    remove_column :ort_cheques, :mark5
  end

  def down
    rename_column :ort_exams, :exam_type_id, :exam_type1_id
    rename_column :ort_cheques, :mark, :mark1
    add_column :ort_exams, :exam_type2_id, :integer
    add_column :ort_exams, :exam_type3_id, :integer
    add_column :ort_exams, :exam_type4_id, :integer
    add_column :ort_exams, :exam_type5_id, :integer
    add_column :ort_cheques, :mark2, :float
    add_column :ort_cheques, :mark3, :float
    add_column :ort_cheques, :mark4, :float
    add_column :ort_cheques, :mark5, :float
  end
end
