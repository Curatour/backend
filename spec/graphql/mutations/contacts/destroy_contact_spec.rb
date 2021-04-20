require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe DestroyContact, type: :request do
      describe 'resolve' do
        it 'removes a contact' do
          user = create(:user)
          contact = create(:contact, user_id: user.id)

          expect do
            post '/graphql', params: { query: g_query(id: contact.id) }
          end.to change { Contact.count }.by(-1)
        end

        it 'returns a contact' do
          user = create(:user)
          contact = create(:contact, user_id: user.id)

          post '/graphql', params: { query: g_query(id: contact.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyContact]

          expect(data).to include(
            id: "#{contact.id}",
            firstName: "#{contact.first_name}",
            lastName: "#{contact.last_name}",
            email: "#{contact.email}",
            phoneNumber: "#{contact.phone_number}",
            note: "#{contact.note}",
            user: { "id": contact.user.id.to_s }
          )
        end
      end

      def g_query(id:)
        <<~GQL
          mutation {
            destroyContact( input: {
              id: #{id}
            }) {
              id
              firstName
              lastName
              email
              phoneNumber
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
