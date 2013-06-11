class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :student_id
      t.integer :test_id
      t.integer :mark
    end
  end
end
