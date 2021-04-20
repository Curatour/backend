require 'rails_helper'

module Mutations
  module Tours
    RSpec.describe DestroyTour, type: :request do
      describe 'resolve' do
        it 'removes an tour' do
          user = create(:user)
          org = create(:organization)
          tour = create(:tour)

          expect do
            post '/graphql', params: { query: g_query(id: tour.id) }
          end.to change { Tour.count }.by(-1)
        end

        it 'returns an tour' do
          user = create(:user)
          org = create(:organization, user_id: user.id)
          tour = create(:tour, organization_id: org.id)

          post '/graphql', params: { query: g_query(id: tour.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyTour]

          expect(data).to include(
            id: "#{tour.id}",
            name: "#{tour.name}",
            startDate: "#{tour.start_date}",
            endDate: "#{tour.end_date}",
            organization: { "id": tour.organization.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyTour( input: {
                id: #{id}
              }) {
                id
                name
                startDate
                endDate
                organization {
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
          organization = create(:organization, user_id: user.id)
          tour = create(:tour, organization_id: organization.id)

          post '/graphql', params: { query: g_query(id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyOrganization( input: {
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
