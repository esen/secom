class CreateOrtCheques < ActiveRecord::Migration
  def change
    create_table :ort_cheques do |t|
      t.integer :participant_id
      t.integer :exam_id
      t.float :mark1
      t.float :mark2
      t.float :mark3
      t.float :mark4
      t.float :mark5

      t.timestamp :created_at
    end
  end
end
