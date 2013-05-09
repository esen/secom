class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :level_id
      t.date :started_at
      t.date :finished_at

      t.timestamps
    end
  end
end
