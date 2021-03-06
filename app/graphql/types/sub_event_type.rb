module Types
  class SubEventType < Types::BaseObject
    field :event, Types::EventType, null: false

    field :id, ID, null: false

    field :name, String, null: false
    field :description, String, null: false
    field :start_time, GraphQL::Types::ISO8601DateTime, null: false
    field :end_time, GraphQL::Types::ISO8601DateTime, null: false
    field :completed, Boolean, null: false

    def event
      Loaders::BelongsToLoader.for(Event).load(object.event_id)
    end
  end
end
