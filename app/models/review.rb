class Review < ApplicationRecord
  belongs_to :user
  belongs_to :history

  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 5 }
  validates :content, presence: true, length: {maximum: 500}, on: :create, allow_nil: false


  def blank_stars
    5 - rating.to_i
   end
end
