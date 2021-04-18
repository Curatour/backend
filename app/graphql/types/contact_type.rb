module Types
  class ContactType < Types::BaseObject
    field :user, Types::UserType, null: false
    
    field :id, ID, null: false

    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: false
    field :email, String, null: false
    field :note, String, null: true
  end
end
