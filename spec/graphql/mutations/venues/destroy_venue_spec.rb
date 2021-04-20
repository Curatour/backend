require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Venues::DestroyVenue, type: :request do
  describe 'Creating a Venue' do

    let(:venue) { create(:venue, name: "Not destroyed") }
    let(:mutation_type) { "destroyVenue" }
    let(:mutation_string) { <<~GQL
      mutation destroyVenue($input: DestroyVenueInput!) {
        destroyVenue(input: $input) {
          id
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
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should delete the object' do
        expect(Venue.all).to be_empty
      end

      it 'should return the Venue object id that was destroyed' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>venue.id.to_s,
        })
      end
    end

    context 'sad path where user input does not provide a Venue ID' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Not destroyed",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
