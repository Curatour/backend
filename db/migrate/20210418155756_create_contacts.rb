class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :note, null: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
