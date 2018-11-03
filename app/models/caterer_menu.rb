class CatererMenu < ApplicationRecord
  #Associations
  belongs_to :user

  #Validations
  validates :description, presence: true
  validates :price, format: { with: /[0-9]/, message: "Please enter amount with numbers" }
end
