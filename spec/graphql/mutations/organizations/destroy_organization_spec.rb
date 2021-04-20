require 'rails_helper'

require 'rails_helper'

module Mutations
  module Organizations
    RSpec.describe DestroyOrganization, type: :request do
      describe 'resolve' do
        it 'removes an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)

          expect do
            post '/graphql', params: { query: g_query(id: organization.id) }
          end.to change { Organization.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)

          post '/graphql', params: { query: g_query(id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyOrganization]

          expect(data).to include(
            id: "#{organization.id}",
            name: "#{organization.name}",
            user: { "id": organization.user.id.to_s }
          )
        end
      end

      def g_query(id:)
        <<~GQL
          mutation {
            destroyOrganization( input: {
              id: #{id}
            }) {
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