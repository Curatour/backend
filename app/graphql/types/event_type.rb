module Types
  class EventType < Types::BaseObject
    field :tour, Types::TourType, null: false
    field :venue, Types::VenueType, null: false
    field :sub_events, [Types::SubEventType], null: false
    
    field :id, ID, null: false

    field :name, String, null: false
    field :start_time, GraphQL::Types::ISO8601DateTime, null: false
    field :end_time, GraphQL::Types::ISO8601DateTime, null: false

    def venue
      Loaders::BelongsToLoader.for(Venue).load(object.venue_id)
    end

    def tour
      Loaders::BelongsToLoader.for(Tour).load(object.tour_id)
    end

    def sub_events
      Loaders::HasManyLoader.for(SubEvent, :event_id).load(object.id)
    end
  end
end
