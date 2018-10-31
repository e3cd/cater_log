class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.date :booking_date
      t.references :user, foreign_key: true
      t.references :caterer_menu, foreign_key: true
      t.decimal :price
      t.text :stripe_charge_id

      t.timestamps
    end
  end
end
