require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:attendances).with_foreign_key('attended_event_id') }
    it { should have_many(:invitations).with_foreign_key('invited_event_id') }
    it { should have_many(:attendees).through(:attendances).source(:attendee) }
    it { should have_many(:guests).through(:invitations).source(:guest) }
  end
end
