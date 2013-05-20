class DeleteOrtParticipantIdFromPayment < ActiveRecord::Migration
  def up
    remove_column :payments, :ort_participant_id
  end

  def down
    add_column :payments, :ort_participant_id, :integer
  end
end
