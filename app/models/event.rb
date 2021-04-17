class Event < ApplicationRecord
  belongs_to :tour
  belongs_to :venue
  has_many :sub_events

  validates_presence_of :name, :tour_id, :venue_id, :start_time, :end_time
end
