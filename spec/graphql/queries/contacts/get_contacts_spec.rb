require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get Users' do

    let(:user) { create(:user) }
    let(:contact) { create(:contact, user: user) }
    let(:query_type_all) { "contacts" }
    let(:query_string_all) { <<~GQL
      { 
        contacts {
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
    }
    let(:query_type_one) { "contact" }
    let(:query_string_one) { <<~GQL
      query contact($id: ID!) { 
        contact(id: $id) {
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
    }

    context 'Get All contacts' do

      before do
        contact
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all contact objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all]).to eq([{
          "id" => contact.id.to_s,
          "firstName" => contact.first_name,
          "lastName" => contact.last_name,
          "phoneNumber" => contact.phone_number,
          "email" => contact.email,
          "note" => contact.note,
          "user" => { 
            "id" => user.id.to_s
          }
        }])
      end
    end

    context 'Get contact' do
      before do
        contact
        query query_string_one,
          variables: {
            id: contact.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one contact object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => contact.id.to_s,
          "firstName" => contact.first_name,
          "lastName" => contact.last_name,
          "phoneNumber" => contact.phone_number,
          "email" => contact.email,
          "note" => contact.note,
          "user" => { 
            "id" => user.id.to_s
          }
        })
      end
    end
  end
end
