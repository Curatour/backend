module Mutations
  module Venues
    class CreateVenue < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :address, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip, String, required: true
      argument :capacity, Integer, required: false

      type Types::VenueType

      def resolve(**attributes)
        Venue.create!(attributes)
      end
    end
  end
end
