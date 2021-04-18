module Types
  class ContactType < Types::BaseObject
    field :id, ID, null: false

    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: false
    field :email, String, null: false
    field :note, String, null: true
  end
end
