module Types
  class TourType < Types::BaseObject
    field :organization, Types::OrganizationType, null: false
    field :events, [Types::EventType], null: false
    field :id, ID, null: false

    field :name, String, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false

    def organization
      Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    end

    def events
      Loaders::HasManyLoader.for(Event, :tour_id).load(object.id)
    end
  end
end
