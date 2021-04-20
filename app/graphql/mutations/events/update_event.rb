module Mutations
  module Events
    class UpdateEvent < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :tour_id, Integer, required: false
      argument :name, String, required: false
      argument :venue_id, Integer, required: false
      argument :start_time, GraphQL::Types::ISO8601DateTime, required: false
      argument :end_time, GraphQL::Types::ISO8601DateTime, required: false

      type Types::EventType

      def resolve(id:, **attributes)
        Event.find(id).tap do |event|
          event.update!(attributes)
        end
      end
    end
  end
end
