module Mutations
  module Organizations
    class UpdateOrganization < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :name, String, required: false
      argument :user_id, Integer, required: false

      type Types::OrganizationType

      def resolve(id:, **attributes)
        Organization.find(id).tap do |org|
          org.update!(attributes)
      end
    end
  end
end
