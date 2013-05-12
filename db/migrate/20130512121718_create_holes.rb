class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
