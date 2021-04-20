require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::SubEvents::UpdateSubEvent, type: :request do
  describe 'Creating a SubEvent' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:venue) { create(:venue) }
    let(:event) { create(:event, venue: venue, tour: tour) }
    let(:sub_event) { create(:sub_event, event: event)}
    let(:mutation_type) { "updateSubEvent" }
    let(:mutation_string) { <<~GQL
      mutation updateSubEvent($input: UpdateSubEventInput!) {
        updateSubEvent(input: $input) {
          id
          name
          description
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: sub_event.id,
              name: "Changed subevent name",
              description: "We gotta do some...different stuff"
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the SubEvent object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>sub_event.id.to_s,
          "name"=>"Changed subevent name",
          "description"=>"We gotta do some...different stuff"
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
