class AddCompletedToSubEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_events, :completed, :boolean, null: false, default: false
  end
end
