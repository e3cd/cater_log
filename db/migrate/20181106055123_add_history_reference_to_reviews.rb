class AddHistoryReferenceToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :history, foreign_key: true
  end
end
