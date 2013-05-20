class ChangeCreatedAtTypeOfOrtPayments < ActiveRecord::Migration
  def up
    change_column :ort_payments, :created_at, :date
  end

  def down
    rename_column :ort_payments, :created_at, :datetime
  end
end
