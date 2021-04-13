module Mutations
  module Events
    class CreateEvent < ::Mutations::BaseMutation
      argument :tour_id, Integer, required: true
      argument :name, String, required: true
      argument :venue_id, Integer, required: true
      argument :start_time, GraphQL::Types::ISO8601Date, required: true
      argument :end_time, GraphQL::Types::ISO8601Date, required: true

      type Types::EventType

      def resolve(tour_id:, **attributes)
        Tour.find(tour_id).events.create!(attributes)
      end
    end
  end
end
