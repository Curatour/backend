module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :phone_number, String, required: false
      argument :email, String, required: false
      argument :role, Integer, required: false

      type Types::UserType

      def resolve(id:, **attributes)
        User.find(id).tap do |user|
          user.update!(attributes)
        end
      end
    end
  end
end
