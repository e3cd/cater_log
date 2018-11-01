class CreateCatererInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :caterer_informations do |t|
      t.string :name
      t.text :number
      t.text :address
      t.text :image
      t.text :about
      t.integer :type_of_event
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
