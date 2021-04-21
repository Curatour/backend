require 'rails_helper'

module Mutations
  module Events
    RSpec.describe UpdateEvent, type: :request do
      describe 'resolve' do
        it 'updates a event' do
          user = create(:user)
          organization = create(:organization)
          venue = create(:venue)
          tour = create(:tour, organization: organization)
          event = create(:event, tour: tour, venue: venue)

          post '/graphql', params: { query: g_query(id: event.id, tour_id: tour.id) }

          expect(event.reload).to have_attributes(
            name: "Rob",
            tour_id: tour.id
          )
        end

        it 'returns a event' do
          user = create(:user)
          organization = create(:organization)
          venue = create(:venue)
          tour = create(:tour, organization: organization)
          event = create(:event, tour: tour, venue: venue)

          post '/graphql', params: { query: g_query(id: event.id, tour_id: tour.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateEvent]

          expect(data).to include(
            id: "#{ event.reload.id }",
            name: "#{ event.name }",
            tour: { "id": tour.id.to_s }
          )
        end

        def g_query(id:, tour_id:)
          <<~GQL
            mutation {
              updateEvent(input: {
                id: #{id}
                name: "Rob"
                tourId: #{tour_id}
              }){
                id
                name
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
          organization = create(:organization)
          venue = create(:venue)
          tour = create(:tour, organization: organization)
          event = create(:event, tour: tour, venue: venue)

          post '/graphql', params: { query: g_query(id: event.id, tour_id: tour.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:, tour_id:)
          <<~GQL
            mutation {
              updateEvent( input: {
                id: 'not an id'
                tour_id: #{tour_id}
              }) {
                id
                tour {
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
