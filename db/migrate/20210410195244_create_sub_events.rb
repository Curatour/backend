class CreateSubEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_events do |t|
      t.string :name
      t.string :description
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
