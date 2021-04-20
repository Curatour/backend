module Mutations
  module SubEvents
    class UpdateSubEvent < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :event_id, Integer, required: false
      argument :name, String, required: false
      argument :description, String, required: false
      argument :completed, Boolean, required: false

      argument :start_time, GraphQL::Types::ISO8601DateTime, required: false
      argument :end_time, GraphQL::Types::ISO8601DateTime, required: false

      type Types::SubEventType

      def resolve(id:, **attributes)
        SubEvent.find(id).tap do |sub_event|
          sub_event.update!(attributes)
        end
      end
    end
  end
end
