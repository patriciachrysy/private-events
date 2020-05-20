class UpdateInvitedEventIdColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :invitations, :invited_events_id, :invited_event_id
  end
end
