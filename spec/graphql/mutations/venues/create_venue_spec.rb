require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Venues::CreateVenue, type: :request do
  describe 'Creating a Venue' do

    let(:mutation_type) { "createVenue" }
    let(:mutation_string) { <<~GQL
      mutation createVenue($input: CreateVenueInput!) {
        createVenue(input: $input) {
          id
          name
          address
          city
          state
          zip
          capacity
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "New Venue Test",
              address: "123 Testing Street",
              city: "Denver",
              state: "CO",
              zip: "80203",
              capacity: 5000
            }
          }
      end


      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the Venue object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>Venue.last.id.to_s,
          "name"=>"New Venue Test",
          "address"=>"123 Testing Street",
          "city"=>"Denver",
          "state"=>"CO",
          "zip"=>"80203",
          "capacity"=>5000
        })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "New Venue Test",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
