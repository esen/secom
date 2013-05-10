class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.string :name
      t.string :surname
      t.date :birth_date
      t.string :school
      t.string :address
      t.string :phone
      t.integer :group_id
      t.integer :discount, :default => 0
      t.date :started_at
      t.date :finished_at
      t.boolean :active, :default => false

      t.timestamps
    end
  end

  def down
    drop_table :students
  end
end
