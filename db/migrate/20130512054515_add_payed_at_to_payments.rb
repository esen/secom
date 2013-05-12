class AddPayedAtToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payed_at, :date
  end
end
