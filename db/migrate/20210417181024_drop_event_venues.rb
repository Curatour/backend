class DropEventVenues < ActiveRecord::Migration[5.2]
  def change
    drop_table :event_venues
  end
end
