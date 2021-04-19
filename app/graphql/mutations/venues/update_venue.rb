module Mutations
  module Venues
    class UpdateVenue < ::Mutations::BaseMutation
      argument :id, ID, required: true

      argument :name, String, required: false
      argument :address, String, required: false
      argument :city, String, required: false
      argument :state, String, required: false
      argument :zip, String, required: false
      argument :capacity, Integer, required: false

      type Types::VenueType

      def resolve(id:, **attributes)
        Venue.find(id).tap do |venue|
          venue.update!(attributes)
        end
      end
    end
  end
end
