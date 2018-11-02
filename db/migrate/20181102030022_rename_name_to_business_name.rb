class RenameNameToBusinessName < ActiveRecord::Migration[5.2]
  def change
    rename_column :caterer_informations, :name, :business_name
  end
end
