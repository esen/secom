class ChangePasswordOfParticipant < ActiveRecord::Migration
  def up
    rename_column :ort_participants, :password, :encrypted_password
  end

  def down
    rename_column :ort_participants, :encrypted_password, :password
  end
end
