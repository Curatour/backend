require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Get All Venues' do
    
    let(:query_type_all) { "venues" }
    let(:query_string_all) { <<~GQL
      { 
        venues {
          id
          name
          address
          city
          state
          zip
          capacity
          events {
            id
          }
        }
      }
      GQL
    }

    before do
      @user = create(:user)
      @organization = create(:organization, user: @user)
      @tour = create(:tour, organization: @organization)
      @venue = create(:venue)
      @events = create_list(:event, 2, venue: @venue, tour: @tour)
      @sub_events = create_list(:sub_event, 5, event: @events.first)
      @contacts = create_list(:contact, 5, user: @user)
    end

    context 'Get All Venue' do

      before do
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should contain all venues as objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all][0]).to eq({
          "id" => @venue.id.to_s,
          "name" => @venue.name,
          "address" => @venue.address,
          "city" => @venue.city,
          "state" => @venue.state,
          "zip"=> @venue.zip,
          "capacity" => @venue.capacity,
          "events" => [
            { "id" => @events.first.id.to_s },
            { "id" => @events.second.id.to_s }
            ]
          })
      end
    end
    
    context 'Get Venue' do
      let(:query_type_one) { "venue" }
      let(:query_string_one) { <<~GQL
        query venue($id: ID!) { 
          venue(id: $id) {
            id
            name
            address
            city
            state
            zip
            capacity
            events {
              id
            }
          }
        }
        GQL
      }

      before do
        query query_string_one,
          variables: {
            id: @venue.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should contain all venues as objects' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => @venue.id.to_s,
          "name" => @venue.name,
          "address" => @venue.address,
          "city" => @venue.city,
          "state" => @venue.state,
          "zip"=> @venue.zip,
          "capacity" => @venue.capacity,
          "events" => [
            { "id" => @events.first.id.to_s },
            { "id" => @events.second.id.to_s }
            ]
          })
      end
    end
  end
end
