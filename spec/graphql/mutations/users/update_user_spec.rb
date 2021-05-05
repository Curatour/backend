require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Users::UpdateUser, type: :request do
  describe 'Creating a User' do

    let(:user) { create(:user) }
    let(:mutation_type) { "updateUser" }
    let(:mutation_string) { <<~GQL
      mutation updateUser($input: UpdateUserInput!) {
        updateUser(input: $input) {
          id
          firstName
          lastName
          email
          phoneNumber
          role
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: user.id,
              firstName: "Updated",
              lastName: "User",
              email: "updated@example.com",
              phoneNumber: "000-555-5555",
              role: 1
            }
          }
      end


      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the User object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>user.id.to_s,
          "email"=>"updated@example.com",
          "firstName"=>"Updated",
          "lastName"=>"User",
          "phoneNumber"=>"000-555-5555",
          "role"=>"member"
        })
      end
    end

    context 'sad path where request is missing required user parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              firstName: "Bad new user",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
