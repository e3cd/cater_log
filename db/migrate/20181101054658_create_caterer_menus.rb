class CreateCatererMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :caterer_menus do |t|
      t.text :description
      t.decimal :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
