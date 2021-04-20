require 'rails_helper'

module Mutations
  module Tours
    RSpec.describe CreateTour, type: :request do
      describe '.resolve' do
        it 'creates a tour' do
          user = create(:user)
          org = create(:organization, user_id: user.id)

          expect do
            post '/graphql', params: { query: g_query(organization_id: org.id) }
          end.to change { Tour.count }.by(1)
        end

        it 'returns a tour' do
          user = create(:user)
          org = create(:organization, user_id: user.id)

          post '/graphql', params: { query: g_query(organization_id: org.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createTour]

          expect(data).to include(
            id: "#{Tour.first.id}",
            name: "Lagrime New Zealand",
            startDate: "#{Tour.first.start_date}",
            endDate: "#{Tour.first.end_date}",
            organization: { "id": org.id.to_s }
          )
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createTour( input: {
                name: "Lagrime New Zealand"
                startDate: "2021-03-21"
                endDate: "2021-05-02"
                organizationId: #{organization_id}
              } ){
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
        it 'returns errors' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)

          post '/graphql', params: { query: g_query(user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(user_id:)
          <<~GQL
            mutation {
              createTour(input: {
                userId: #{user_id}
              } ){
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
