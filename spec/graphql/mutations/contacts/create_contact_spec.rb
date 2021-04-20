require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe CreateContact, type: :request do
      describe '.resolve' do
        it 'creates a contact' do
          user = create(:user)

          expect do
            post '/graphql', params: { query: g_query(user_id: user.id) }
          end.to change { Contact.count }.by(1)
        end

        it 'returns a contact' do
          user = create(:user)

          post '/graphql', params: { query: g_query(user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createContact]

          expect(data).to include(
            id: "#{ Contact.first.id }",
            firstName: "#{ Contact.first.first_name }",
            lastName: "#{ Contact.first.last_name }",
            phoneNumber: "#{ Contact.first.phone_number }",
            email: "#{ Contact.first.email }",
            note: "#{ Contact.first.note }",
            user: { "id": user.id.to_s }
          )
        end
      end

      def g_query(user_id:)
        <<~GQL
          mutation {
            createContact( input: {
              firstName: "Robert"
              lastName: "Heath"
              phoneNumber: "3043873230"
              email: "123@me.com"
              note: "works for the LAMC"
              userId: #{user_id}
            } ){
              id
              firstName
              lastName
              phoneNumber
              email
              note
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
