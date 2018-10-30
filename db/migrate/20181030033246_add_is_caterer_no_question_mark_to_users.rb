class AddIsCatererNoQuestionMarkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_caterer, :boolean
  end
end
