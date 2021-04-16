class AddTimesToSubEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_events, :start_time, :datetime
    add_column :sub_events, :end_time, :datetime
  end
end
