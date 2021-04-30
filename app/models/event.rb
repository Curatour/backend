class Event < ApplicationRecord
  belongs_to :tour
  belongs_to :venue
  has_many :sub_events, dependent: :destroy

  validates_presence_of :name, :tour_id, :venue_id, :start_time, :end_time
  validates_datetime :end_time, after: :start_time
end
