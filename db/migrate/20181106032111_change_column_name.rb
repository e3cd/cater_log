class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :histories, :number, :caterer_name
  end
end
