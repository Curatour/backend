module Mutations
  module Contacts
    class UpdateContact < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :user_id, Integer, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :phone_number, String, required: false
      argument :email, String, required: false
      argument :note, String, required: false

      type Types::ContactType

      def resolve(id:, **attributes)
        Contact.find(id).tap do |contact|
          contact.update!(attributes)
        end
      end
    end
  end
end
