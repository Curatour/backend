class AddOrganizationToTour < ActiveRecord::Migration[5.2]
  def change
    add_reference :tours, :organization, foreign_key: true
  end
end
