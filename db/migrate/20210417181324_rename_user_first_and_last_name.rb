class RenameUserFirstAndLastName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :firstName, :first_name
    rename_column :users, :lastName, :last_name
  end
end
