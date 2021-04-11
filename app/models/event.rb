class Event < ApplicationRecord
  belongs_to :tour
  has_many :sub_events
  has_many :event_venues
  has_many :venues, through: :event_venues

  validates_presence_of :name, :tour_id, :venue_id, :date, :start_time, :end_time
end
