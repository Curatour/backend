class CreateOrganizationTours < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_tours do |t|
      t.references :organization_id, foreign_key: true
      t.references :tour_id, foreign_key: true

      t.timestamps
    end
  end
end
