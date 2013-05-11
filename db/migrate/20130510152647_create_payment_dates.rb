class CreatePaymentDates < ActiveRecord::Migration
  def change
    create_table :payment_dates do |t|
      t.integer :group_id
      t.date :payment_date
      t.integer :amount

      t.timestamps
    end
  end
end
