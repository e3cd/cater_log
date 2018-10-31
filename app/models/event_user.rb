class EventUser < ApplicationRecord
  has_many :event_types
  has_many :users
end
