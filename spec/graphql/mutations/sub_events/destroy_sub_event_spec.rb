require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::SubEvents::UpdateSubEvent, type: :request do
  describe 'Destroying a SubEvent' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: organization) }
    let(:venue) { create(:venue) }
    let(:event) { create(:event, venue: venue, tour: tour) }
    let(:sub_event) { create(:sub_event, event: event)}
    let(:mutation_type) { "destroySubEvent" }
    let(:mutation_string) { <<~GQL
      mutation destroySubEvent($input: DestroySubEventInput!) {
        destroySubEvent(input: $input) {
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
              id: sub_event.id,
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should delete the object' do
        expect(SubEvent.all).to be_empty
      end

      it 'should return the SubEvent object id that was destroyed' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>sub_event.id.to_s,
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
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
