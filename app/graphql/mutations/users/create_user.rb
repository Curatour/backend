module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :phone_number, String, required: true
      argument :email, String, required: true
      argument :role, Integer, required: true

      type Types::UserType

      def resolve(**attributes)
        User.create!(attributes)
      end
    end
  end
end
