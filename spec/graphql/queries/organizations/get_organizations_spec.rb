require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get Users' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:query_type_all) { "organizations" }
    let(:query_string_all) { <<~GQL
      { 
        organizations {
          id
          name
          user {
            id
          }
        }
      }
    GQL
    }
    let(:query_type_one) { "organization" }
    let(:query_string_one) { <<~GQL
      query organization($id: ID!) { 
        organization(id: $id) {
          id
          name
          user {
            id
          }
        }
      }
    GQL
    }

    context 'Get All Organizations' do

      before do
        organization
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all organization objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all]).to eq([{
          "id" => organization.id.to_s,
          "name" => organization.name,
          "user" => { 
            "id" => user.id.to_s
          }
        }])
      end
    end

    context 'Get All Organizations' do
      before do
        organization
        query query_string_one,
          variables: {
            id: organization.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one organization object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => organization.id.to_s,
          "name" => organization.name,
          "user" => { 
            "id" => user.id.to_s
          }
        })
      end
    end
  end
end
