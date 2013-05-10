class AddPriceToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :price, :integer, :default => 0
  end
end
