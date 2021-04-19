module Types
  class SubEventType < Types::BaseObject
    field :event, Types::SubEventType, null: false

    field :id, ID, null: false

    field :name, String, null: false
    field :description, String, null: false
    field :start_time, GraphQL::Types::ISO8601DateTime, null: false
    field :end_time, GraphQL::Types::ISO8601DateTime, null: false
    field :completed, Boolean, null: false
  end
end
