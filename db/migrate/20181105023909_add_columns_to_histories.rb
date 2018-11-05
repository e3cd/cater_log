class AddColumnsToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :first_name, :string
    add_column :histories, :email, :string
    add_column :histories, :number, :string
  end
end
