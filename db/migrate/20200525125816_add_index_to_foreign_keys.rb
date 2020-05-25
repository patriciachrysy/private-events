class AddIndexToForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_index :events, :creator_id
    
    add_index :attendances, :attendee_id
    add_index :attendances, :attended_event_id
    
    add_index :invitations, :guest_id
    add_index :invitations, :invited_event_id
    #Ex:- add_index("admin_users", "username")
  end
end
