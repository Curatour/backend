class SubEvent < ApplicationRecord
  belongs_to :event

  validates_presence_of :name, :description, :event_id
end
