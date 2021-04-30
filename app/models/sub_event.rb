class SubEvent < ApplicationRecord
  belongs_to :event

  validates_presence_of :name, :description, :event_id
  validates_datetime :end_time, after: :start_time
end
