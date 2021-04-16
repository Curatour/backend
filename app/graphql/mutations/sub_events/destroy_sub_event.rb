module Mutations
  module SubEvents
    class DestroySubEvent < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::SubEventType

      def resolve(id:)
        SubEvent.find(id).destroy
      end
    end
  end
end
