class AddBranchIdToOrtPayments < ActiveRecord::Migration
  def change
    add_column :ort_payments, :branch_id, :integer
  end
end
