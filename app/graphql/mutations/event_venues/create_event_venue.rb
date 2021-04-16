module Mutations
  module EventVenues
    class CreateEventVenue < ::Mutations::BaseMutation
      argument :event_id, Integer, required: true
      argument :venue_id, Integer, required: true

      type Types::EventVenueType

      def resolve(event_id:, venue_id:)
        require 'pry'; binding.pry
        Event.find(event_id).event_venues.create!(venue_id: venue_id)
      end
    end
  end
end
