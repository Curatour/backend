class DropOrganizationTours < ActiveRecord::Migration[5.2]
  def change
    drop_table :organization_tours
  end
end
