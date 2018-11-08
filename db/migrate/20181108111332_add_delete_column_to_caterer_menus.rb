class AddDeleteColumnToCatererMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :caterer_menus, :is_deleted, :boolean
  end
end
