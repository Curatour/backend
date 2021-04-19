module Types
  class OrganizationType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :tours, [Types::TourType], null: false

    field :id, ID, null: false

    field :name, String, null: false

    def user
      Loaders::BelongsToLoader.for(User).load(object.user_id)
    end

    def tours
      Loaders::HasManyLoader.for(Tour, :organization_id).load(object.id)
    end
  end
end
