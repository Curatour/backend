module Mutations
  module Organizations
    class CreateOrganization < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :user_id, Integer, required: true

      type Types::OrganizationType

      def resolve(user_id:, **attributes)
        User.find(user_id).organizations.create!(attributes)
      end
    end
  end
end
