require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Users::CreateUser, type: :request do
  describe 'Creating a User' do

    let(:mutation_type) { "createUser" }
    let(:mutation_string) { <<~GQL
      mutation createUser($input: CreateUserInput!) {
        createUser(input: $input) {
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
              firstName: "New",
              lastName: "User",
              email: "new_user@example.com",
              phoneNumber: "555-555-5555",
              role: 0
            }
          }
      end


      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the User object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id"=>User.last.id.to_s,
          "email"=>"new_user@example.com",
          "firstName"=>"New",
          "lastName"=>"User",
          "phoneNumber"=>"555-555-5555",
          "role"=>"admin"
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
