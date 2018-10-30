class RemoveIsCatererFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_caterer?, :boolean
  end
end
