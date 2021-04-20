require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::SubEvents::CreateSubEvent, type: :request do
  describe 'Creating a SubEvent' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:venue) { create(:venue) }
    let(:event) { create(:event, venue: venue, tour: tour) }
    let(:mutation_type) { "createSubEvent" }
    let(:mutation_string) { <<~GQL
      mutation createSubEvent($input: CreateSubEventInput!) {
        createSubEvent(input: $input) {
          name
          description
          startTime
          endTime
          event {
            id
          }
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              eventId: event.id,
              name: "New subevent",
              description: "We gotta do some stuff",
              startTime: "2021-08-23T18:30:00-06:00",
              endTime: "2021-08-23T21:30:00-06:00"
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the SubEvent object' do
        expect(gql_response.data[mutation_type]).to eq({
            "name"=>"New subevent",
            "description"=>"We gotta do some stuff",
            "startTime"=>"2021-08-24T00:30:00Z",
            "endTime"=>"2021-08-24T03:30:00Z",
            "event"=>
              {
                "id"=>event.id.to_s
              }
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Invalid input subevent",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
