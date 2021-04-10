class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :phone_number
      t.string :email
      t.integer :role

      t.timestamps
    end
  end
end
