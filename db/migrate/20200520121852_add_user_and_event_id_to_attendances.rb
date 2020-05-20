class AddUserAndEventIdToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :attendee_id, :integer
    add_column :attendances, :attended_event_id, :integer
  end
end
