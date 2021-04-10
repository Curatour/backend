class CreateEventVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :event_venues do |t|
      t.references :event, foreign_key: true
      t.references :venue, foreign_key: true
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email

      t.timestamps
    end
  end
end
