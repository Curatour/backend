require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe UpdateContact, type: :request do
      describe 'resolve' do
        it 'updates a contact' do
          user = create(:user)
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id, user_id: user.id) }

          expect(contact.reload).to have_attributes(
            first_name: "Rob",
            last_name: "MacIlravy",
            email: "theone@me.com",
            phone_number: "3023334444",
            note: "not a fan",
            user_id: user.id
          )
        end

        it 'returns a contact' do
          user = create(:user)
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id, user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateContact]

          expect(data).to include(
            id: "#{ contact.reload.id }",
            firstName: "#{ contact.first_name }",
            lastName: "#{ contact.last_name }",
            phoneNumber: "#{ contact.phone_number }",
            email: "#{ contact.email }",
            note: "#{ contact.note }",
            user: { "id": user.id.to_s }
          )
        end

        def g_query(id:, user_id:)
          <<~GQL
            mutation {
              updateContact(input: {
                id: #{id}
                firstName: "Rob"
                lastName: "MacIlravy"
                phoneNumber: "3023334444"
                email: "theone@me.com"
                note: "not a fan"
                userId: #{user_id}
              }){
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

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          contact = create(:contact, user_id: user.id)

          post '/graphql', params: { query: g_query(id: contact.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyContact( input: {
                id: 'not an id'
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
end
