class AddCatererMenuRefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user, foreign_key: true
  end
end
