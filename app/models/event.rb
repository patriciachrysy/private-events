class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :attendee

  has_many :invitations, foreign_key: 'invited_event_id'
  has_many :guests, through: :invitations, source: :guest

  scope :upcoming, -> {where("event_date >= ?",DateTime.now)}
  scope :previous, -> {where("event_date < ?",DateTime.now)}
end
