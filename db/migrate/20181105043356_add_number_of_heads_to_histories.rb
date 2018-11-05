class AddNumberOfHeadsToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :number_of_heads, :integer
  end
end
