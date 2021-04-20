require 'rails_helper'

module Mutations
  module Tours
    RSpec.describe UpdateTour, type: :request do
      describe 'resolve' do
        it 'updates a tour' do
          user = create(:user)
          organization = create(:organization)
          tour = create(:tour)

          post '/graphql', params: { query: g_query(id: tour.id, organization_id: organization.id) }

          expect(tour.reload).to have_attributes(
            name: "Rob",
            organization_id: organization.id
          )
        end

        it 'returns a tour' do
          user = create(:user)
          organization = create(:organization)
          tour = create(:tour)

          post '/graphql', params: { query: g_query(id: tour.id, organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateTour]

          expect(data).to include(
            id: "#{ tour.reload.id }",
            name: "#{ tour.name }",
            organization: { "id": organization.id.to_s }
          )
        end

        def g_query(id:, organization_id:)
          <<~GQL
            mutation {
              updateTour(input: {
                id: #{id}
                name: "Rob"
                organizationId: #{organization_id}
              }){
                id
                name
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

          post '/graphql', params: { query: g_query(id: tour.id, organization_id: organization.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:, organization_id:)
          <<~GQL
            mutation {
              updateTour( input: {
                id: 'not an id'
                organization_id: 1
              }) {
                id
                organization {
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
