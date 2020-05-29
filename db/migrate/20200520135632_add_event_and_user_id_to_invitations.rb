class AddEventAndUserIdToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :guest_id, :integer
    add_column :invitations, :invited_events_id, :integer
  end
end
