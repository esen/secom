class CreateOrtExamTypes < ActiveRecord::Migration
  def change
    create_table :ort_exam_types do |t|
      t.string :name
      t.float :cost

      t.timestamps
    end
  end
end
