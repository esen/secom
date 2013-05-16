class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :amount
      t.integer :teacher_id
      t.integer :hole_id
      t.string :note
      t.date :expended_at

      t.timestamps
    end
  end
end
