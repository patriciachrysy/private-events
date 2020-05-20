class Invitation < ApplicationRecord
    belongs_to :guest, class_name: 'User'
    belongs_to :invited_event, class_name: 'Event'
end
