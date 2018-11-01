class EventUser < ApplicationRecord
  belongs_to :user
  has_one :event_type
end
