class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      
      t.timestamps
    end
  end
end
