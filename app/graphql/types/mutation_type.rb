module Types
  class MutationType < Types::BaseObject
    field :create_organization, mutation: Mutations::Organizations::CreateOrganization
  end
end
