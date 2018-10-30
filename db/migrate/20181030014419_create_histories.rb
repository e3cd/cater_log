class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.date :booking_date
      t.integer :user_id
      t.integer :caterermenu_id
      t.decimal :price
      t.text :stripe_charge_id

      t.timestamps
    end
  end
end
