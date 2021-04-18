module Mutations
  module Contacts
    class CreateContact < ::Mutations::BaseMutation
      argument :user_id, Integer, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :phone_number, String, required: true
      argument :email, String, required: true
      argument :note, String, required: false

      type Types::ContactType

      def resolve(user_id:, **attributes)
        User.find(user_id).contacts.create!(attributes)
      end
    end
  end
end
