class CreateOrtExams < ActiveRecord::Migration
  def change
    create_table :ort_exams do |t|
      t.float :cost
      t.integer :exam_type1_id
      t.integer :exam_type2_id
      t.integer :exam_type3_id
      t.integer :exam_type4_id
      t.integer :exam_type5_id

      t.timestamps
    end
  end
end
