module Types
  class EventVenueType < Types::BaseObject
    field :event, Types::EventType, null: false
    field :venue, Types::VenueType, null: false

    field :id, ID, null: false

    field :contact_name, String, null: false
    field :contact_phone, String, null: false
    field :contact_email, String, null: false
  end
end
