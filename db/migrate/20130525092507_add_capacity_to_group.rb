class AddCapacityToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :capacity, :integer
  end
end
