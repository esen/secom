class CreateOrtPayments < ActiveRecord::Migration
  def change
    create_table :ort_payments do |t|
      t.integer :participant_id
      t.integer :exam_id
      t.float :amount

      t.timestamp :created_at
    end
  end
end
