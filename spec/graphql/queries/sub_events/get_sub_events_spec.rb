require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get SubEvents' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:venue) { create(:venue) }
    let(:event) { create(:event, venue: venue, tour: tour) }
    let(:sub_event) {create(:sub_event, event: event)}
    let(:query_type_all) { "subEvents" }
    let(:query_string_all) { <<~GQL
      { 
        subEvents {
          id
          name
        }
      }
    GQL
    }
    let(:query_type_one) { "subEvent" }
    let(:query_string_one) { <<~GQL
      query subEvent($id: ID!) { 
        subEvent(id: $id) {
          id
          name
        }
      }
    GQL
    }

    context 'Get All SubEvents' do

      before do
        sub_event
        query query_string_all
      end

      fit 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all event objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all]).to eq([{
          "id" => sub_event.id.to_s,
          "name" => sub_event.name,
        }])
      end
    end

    context 'Get Event' do
      before do
        sub_event
        query query_string_one,
          variables: {
            id: sub_event.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one event object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => sub_event.id.to_s,
          "name" => sub_event.name,
        })
      end
    end
  end
end
