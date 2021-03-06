module Mutations
  module Events
    class DestroyEvent < ::Mutations::BaseMutation
      argument :id, ID, required: true

      type Types::EventType

      def resolve(id:)
        Event.find(id).destroy
      end
    end
  end
end
