require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'Nested query' do
    before do
      @user = create(:user)
      @organization = create(:organization, user: @user)
      @tour = create(:tour, organization: @organization)
      @venue = create(:venue)
      @event = create(:event, venue: @venue, tour: @tour)
      @sub_events = create_list(:sub_event, 5, event: @event)
      @contacts = create_list(:contact, 5, user: @user)
    end

    let(:query_type) { "user" }
    let(:query_string) { <<~GQL
      query user($id: ID!) { 
        user(id: $id) {
          contacts {
            id
            firstName
            lastName
            email
            phoneNumber
            note
          }
            organizations {
            tours {
              id
              name
              events {
                id
                name
                startTime
                endTime
                subEvents {
                  id
                  name
                  description
                  startTime
                  endTime
                  completed
                }
                venue {
                  id
                  name
                  address
                  city
                  state
                  zip
                  capacity
                }
              }
            }
          }
        }
      }
    GQL
    }

    context 'happy path' do
      
      before do 
        query query_string,
        variables: {
          id: @user.id
        }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return nested objects' do
        expect(gql_response.data.keys).to eq([query_type])
        expect(gql_response.data[query_type].keys).to eq(["contacts", "organizations"])
        
        expect(gql_response.data[query_type]["contacts"]).to be_an Array
        expect(gql_response.data[query_type]["contacts"][0].keys).to eq(
          ["id", "firstName", "lastName", "email", "phoneNumber", "note"]
        )
        
        expect(gql_response.data[query_type]["organizations"]).to be_an Array
        expect(gql_response.data[query_type]["organizations"][0].keys).to eq(["tours"])
        
        expect(gql_response.data[query_type]["organizations"][0]["tours"]).to be_an Array
        expect(gql_response.data[query_type]["organizations"][0]["tours"][0].keys).to eq(["id", "name", "events"])
        
        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"]).to be_an Array
        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"][0].keys).to eq(
          ["id", "name", "startTime", "endTime", "subEvents", "venue"])
        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"][0].keys).to eq(
          ["id", "name", "startTime", "endTime", "subEvents", "venue"]
        )

        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"][0]["venue"].keys).to eq(
          ["id", "name", "address", "city", "state", "zip", "capacity"]
        )

        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"][0]["subEvents"]).to be_an Array
        expect(gql_response.data[query_type]["organizations"][0]["tours"][0]["events"][0]["subEvents"][0].keys).to eq(
          ["id", "name", "description", "startTime", "endTime", "completed"]
        )
      end
    end
  end
end
