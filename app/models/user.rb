class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances, source: :attended_event

  has_many :invitations, foreign_key: 'guest_id'
  has_many :invited_events, through: :invitations, source: :invited_event

  validates_uniqueness_of :username

  def pending_events?(event)
    invited_events.include?(event) &&
      !attended_events.include?(event)
  end
end
