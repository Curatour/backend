module Types
  class VenueType < Types::BaseObject
    field :id, ID, null: false

    field :name, String, null: false
    field :address, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :capacity, Integer, null: true
  end
end
