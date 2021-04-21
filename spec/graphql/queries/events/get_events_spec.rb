require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get Events' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:venue) { create(:venue) }
    let(:event) { create(:event, venue: venue, tour: tour) }
    let(:query_type_all) { "events" }
    let(:query_string_all) { <<~GQL
      { 
        events {
          id
          name
          subEvents {
            id
          }
        }
      }
    GQL
    }
    let(:query_type_one) { "event" }
    let(:query_string_one) { <<~GQL
      query event($id: ID!) { 
        event(id: $id) {
          id
          name
          subEvents {
            id
          }
        }
      }
    GQL
    }

    context 'Get All Events' do

      before do
        event
        query query_string_all
      end

      fit 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all event objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all]).to eq([{
          "id" => event.id.to_s,
          "name" => event.name,
          "subEvents" => []
        }])
      end
    end

    context 'Get Event' do
      before do
        event
        query query_string_one,
          variables: {
            id: event.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one event object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => event.id.to_s,
          "name" => event.name,
          "subEvents" => []
        })
      end
    end
  end
end
