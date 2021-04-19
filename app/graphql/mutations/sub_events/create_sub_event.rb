module Mutations
  module SubEvents
    class CreateSubEvent < ::Mutations::BaseMutation
      argument :event_id, Integer, required: true
      argument :name, String, required: true
      argument :description, String, required: true

      argument :start_time, GraphQL::Types::ISO8601Date, required: true
      argument :end_time, GraphQL::Types::ISO8601Date, required: true

      type Types::SubEventType

      def resolve(event_id:, **attributes)
        Event.find(event_id).sub_events.create!(attributes)
      end
    end
  end
end
