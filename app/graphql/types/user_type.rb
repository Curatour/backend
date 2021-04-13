module Types
  class UserType < Types::BaseObject
    field :organizations, [Types::OrganizationType], null: true

    field :id, ID, null: false

    field :firstName, String, null: false
    field :lastName, String, null: false
    field :phone_number, String, null: false
    field :email, String, null: false
    field :role, String, null: false
  end
end
