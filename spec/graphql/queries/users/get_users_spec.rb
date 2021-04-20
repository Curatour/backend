require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get Users' do

    let(:user) { create(:user) }
    let(:query_type) { "users" }
    let(:query_string) { <<~GQL
      { 
        users {
          id
          firstName
          lastName
          email
          phoneNumber
          role
        }
      }
    GQL
    }

    context 'Get All Users' do

      before do
        user
        query query_string
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should contain all users as objects' do
        expect(gql_response.data[query_type]).to be_an Array
        expect(gql_response.data[query_type][0]).to eq({
          "id" => user.id.to_s,
          "firstName" => user.first_name,
          "lastName" => user.last_name,
          "email" => user.email,
          "phoneNumber" => user.phone_number,
          "role" => user.role
          })
      end
    end
  end
end
