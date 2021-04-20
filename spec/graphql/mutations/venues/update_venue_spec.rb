require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Venues::UpdateVenue, type: :request do
  describe 'Creating a Venue' do

    let(:venue) { create(:venue, name: "Not Updated") }
    let(:mutation_type) { "updateVenue" }
    let(:mutation_string) { <<~GQL
      mutation updateVenue($input: UpdateVenueInput!) {
        updateVenue(input: $input) {
          id
          name
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: venue.id,
              name: "Updated Name"
            }
          }
      end


      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the Venue object with updated attribute' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>venue.id.to_s,
          "name"=>"Updated Name"
        })
      end
    end

    context 'sad path where user input does not provide a Venue ID' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Update Name",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
