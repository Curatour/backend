module Mutations
  module Tours
    class CreateTour < ::Mutations::BaseMutation
      argument :organization_id, Integer, required: true
      argument :name, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true

      type Types::TourType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).tours.create!(attributes)
      end
    end
  end
end
