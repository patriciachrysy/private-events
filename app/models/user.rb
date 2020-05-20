class User < ApplicationRecord
    validates_uniqueness_of :username
    has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
    
end
