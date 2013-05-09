class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :surname
      t.string :phone
      t.string :address
      t.integer :lesson_id

      t.timestamps
    end
  end
end
