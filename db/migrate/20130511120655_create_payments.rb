class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :student_id
      t.integer :ort_participant_id
      t.integer :source_id
      t.string :note
      t.integer :amount

      t.timestamps
    end
  end
end
