require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get Users' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:query_type_all) { "tours" }
    let(:query_string_all) { <<~GQL
      { 
        tours {
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
    }
    let(:query_type_one) { "tour" }
    let(:query_string_one) { <<~GQL
      query tour($id: ID!) { 
        tour(id: $id) {
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
    }

    context 'Get All Tours' do

      before do
        tour
        query query_string_all
      end

      fit 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all tour objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all]).to eq([{
          "id" => tour.id.to_s,
          "name" => tour.name,
          "startDate" => tour.start_date.strftime('%Y-%m-%d'),
          "endDate" => tour.end_date.strftime('%Y-%m-%d'),
          "organization" => { 
            "id" => organization.id.to_s
          }
        }])
      end
    end

    context 'Get Tour' do
      before do
        tour
        query query_string_one,
          variables: {
            id: tour.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one tour object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => tour.id.to_s,
          "name" => tour.name,
          "startDate" => tour.start_date.strftime('%Y-%m-%d'),
          "endDate" => tour.end_date.strftime('%Y-%m-%d'),
          "organization" => { 
            "id" => organization.id.to_s
          }
        })
      end
    end
  end
end
