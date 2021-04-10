class EventVenue < ApplicationRecord
  belongs_to :venue
  belongs_to :event

  validates_presence_of :event_id, :venue_id, :contact_name, :contact_phone, :contact_email
end
