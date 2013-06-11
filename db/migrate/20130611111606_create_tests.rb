class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.date :test_date
      t.boolean :homework
      t.integer :course_id

      t.timestamps
    end
  end
end
