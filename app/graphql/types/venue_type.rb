module Types
  class VenueType < Types::BaseObject
    field :events, [Types::EventType], null: false
    
    field :id, ID, null: false

    field :name, String, null: false
    field :address, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :capacity, Integer, null: false
  end
end
