module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false do
      description 'Find all users'
    end

    field :user, Types::UserType, null: false do
      description 'Find user by ID'
      argument :id, ID, required: true
    end

    field :organizations, [Types::OrganizationType], null: false do
      description 'Find all organizations'
    end

    field :organization, Types::OrganizationType, null: false do
      description 'Find organization by ID'
      argument :id, ID, required: true
    end

    field :tours, [Types::TourType], null: false do
      description 'Find all tours'
    end

    field :tour, Types::TourType, null: false do
      description 'Find tour by ID'
      argument :id, ID, required: true
    end

    field :events, [Types::EventType], null: false do
      description 'Find all events'
    end

    field :event, Types::EventType, null: false do
      description 'Find event by ID'
      argument :id, ID, required: true
    end

    field :venues, [Types::VenueType], null: false do
      description 'Find all venues'
    end

    field :venue, Types::VenueType, null: false do
      description 'Find venue by ID'
      argument :id, ID, required: true
    end

    field :venueByName, [Types::VenueType], null: false do
      description 'Find venue by name'
      argument :name, String, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    def organizations
      Organization.all
    end

    def organization(id:)
      Organization.find(id)
    end

    def tours
      Tour.all
    end

    def tour(id:)
      Tour.find(id)
    end

    def events
      Event.all
    end

    def event(id:)
      Event.find(id)
    end

    def venues
      Venue.all
    end

    def venue(id:)
      Venue.find(id)
    end

    def venueByName(name:)
      Venue.where('name ILIKE ?', "%#{name}%")
    end
  end
end
