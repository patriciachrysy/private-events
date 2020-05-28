require "rails_helper"

RSpec.describe Invitation, :type => :model do
    describe 'associations' do
        it { should belong_to(:guest).class_name('User') }
        it { should belong_to(:invited_event).class_name('Event') }
    end
end