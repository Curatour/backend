module Types
  class EventType < Types::BaseObject
    field :tour, Types::TourType, null: false
    field :venue, Types::VenueType, null: false
    
    field :id, ID, null: false

    field :name, String, null: false
    field :start_time, GraphQL::Types::ISO8601DateTime, null: false
    field :end_time, GraphQL::Types::ISO8601DateTime, null: false
  end
end
