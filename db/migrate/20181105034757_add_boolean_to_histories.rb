class AddBooleanToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :has_paid, :boolean
  end
end
