module Types
  class SubEventType < Types::BaseObject
    field :event, Types::EventType, null: false

    field :id, ID, null: false

    field :name, String, null: false
    field :description, String, null: false
    field :start_time, GraphQL::Types::ISO8601Date, null: false
    field :end_time, GraphQL::Types::ISO8601Date, null: false
  end
end
