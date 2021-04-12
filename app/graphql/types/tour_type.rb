module Types
  class TourType < Types::BaseObject
    field :organization, Types::OrganizationType, null: false

    field :id, ID, null: false

    field :name, String, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false
  end
end
