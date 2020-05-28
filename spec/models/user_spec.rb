require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:created_events).with_foreign_key('creator_id') }
    it { should have_many(:attendances).with_foreign_key('attendee_id') }
    it { should have_many(:invitations).with_foreign_key('guest_id') }
    it { should have_many(:attended_events).through(:attendances).source(:attended_event) }
    it { should have_many(:invited_events).through(:invitations).source(:invited_event) }
  end

  describe 'validations' do
    subject { User.create(name: 'Test user', username: 'Testor', email: 'textor@test.com') }

    it { should validate_uniqueness_of(:username) }
  end
end
