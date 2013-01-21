class CreateOrtParticipants < ActiveRecord::Migration
  def change
    create_table :ort_participants do |t|
      t.string :name
      t.string :password

      t.timestamp :created_at
    end
  end
end
