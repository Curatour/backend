module Types
  class OrganizationType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :tours, Types::TourType, null: false

    field :id, ID, null: false

    field :name, String, null: false
  end
end