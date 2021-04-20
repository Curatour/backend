require 'rails_helper'

module Mutations
  module Events
    RSpec.describe DestroyEvent, type: :request do
      describe 'resolve' do
        it 'removes an event' do
          user = create(:user)
          org = create(:organization)
          tour = create(:tour, organization: org)
          venue = create(:venue)
          event = create(:event, venue_id: venue.id, tour_id: tour.id)

          expect do
            post '/graphql', params: { query: g_query(id: event.id) }
          end.to change { Event.count }.by(-1)
        end

        it 'returns an event' do
          user = create(:user)
          org = create(:organization)
          tour = create(:tour, organization: org)
          venue = create(:venue)
          event = create(:event, venue_id: venue.id, tour_id: tour.id)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyEvent]
          
          expect(data).to include(
            id: "#{event.id}",
            name: "#{event.name}",
            # startTime: "#{event.start_time}",
            # endTime: "#{event.end_time}",
            tour: { "id": event.tour.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEvent( input: {
                id: #{id}
              }) {
                id
                name
                startTime
                endTime
                tour {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          org = create(:organization)
          tour = create(:tour, organization: org)
          venue = create(:venue)
          event = create(:event, venue_id: venue.id, tour_id: tour.id)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEvent( input: {
                id: 'not an id'
              }) {
                id
                user {
                  id
                }
              }
            }
          GQL
        end
      end
    end
  end
end
