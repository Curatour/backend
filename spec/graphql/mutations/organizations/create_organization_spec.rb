require 'rails_helper'

module Mutations
  module Organizations
    RSpec.describe CreateOrganization, type: :request do
      describe '.resolve' do
        it 'creates an organization' do
          user = create(:user)

          expect do
            post '/graphql', params: { query: g_query(user_id: user.id) }
          end.to change { Organization.count }.by(1)
        end

        it 'returns an organization' do
          user = create(:user)

          post '/graphql', params: { query: g_query(user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createOrganization]

          expect(data).to include(
            id: "#{Organization.first.id}",
            name: "LAMC",
            user: { "id": user.id.to_s }
          )
        end
      end

      def g_query(user_id:)
        <<~GQL
          mutation {
            createOrganization( input: {
              name: "LAMC"
              userId: #{user_id}
            } ){
              id
              name
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
