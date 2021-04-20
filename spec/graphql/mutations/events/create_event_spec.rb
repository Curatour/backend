require 'rails_helper'

module Mutations
  module Events
    RSpec.describe CreateEvent, type: :request do
      describe 'resolve' do
        it 'creates an event' do
          user = create(:user)
          org = create(:organization, user_id: user.id)
          venue = create(:venue)
          tour = create(:tour, organization: org)

          expect do
            post '/graphql', params: { query: g_query(tour_id: tour.id, venue_id: venue.id) }
          end.to change { Event.count }.by(1)
        end

        it 'returns an event' do
          user = create(:user)
          org = create(:organization, user_id: user.id)
          venue = create(:venue)
          tour = create(:tour, organization_id: org.id)

          post '/graphql', params: { query: g_query(tour_id: tour.id, venue_id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createEvent]

          expect(data).to include(
            id: "#{Event.first.id}",
            name: "Lagrime New Zealand",
            startTime: "2021-04-20T20:44:46Z",
            endTime: "2021-04-20T20:44:46Z",
            tour: { "id": tour.id.to_s },
            venue: { "id": venue.id.to_s }
          )
        end

        def g_query(tour_id:, venue_id:)
          <<~GQL
            mutation {
              createEvent( input: {
                name: "Lagrime New Zealand"
                startTime: "2021-04-20T20:44:46Z"
                endTime: "2021-04-20T20:44:46Z"
                tourId: #{tour_id}
                venueId: #{venue_id}
              } ){
                id
                name
                startTime
                endTime
                venue {
                  id
                }
                tour {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns errors' do
          user = create(:user)
          org = create(:organization, user_id: user.id)
          venue = create(:venue)
          tour = create(:tour, organization_id: org.id)

          post '/graphql', params: { query: g_query(tour_id: tour.id, venue_id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(tour_id:, venue_id:)
          <<~GQL
            mutation {
              createEvent(input: {
                tourId: #{tour_id}
                venueId: 'not an id'
              } ){
                id
              }
            }
          GQL
        end
      end
    end
  end
end
