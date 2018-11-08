class CatererInformation < ApplicationRecord
  #Association to user_id and ability to upload image
  belongs_to :user
  mount_uploader :image, ImageUploader
  before_save :remove_whitespace

  #Enums used for dropdown menu in rego form ... saved as enum in CatererInfo database
  enum type_of_event: [:Wedding, :Party, :Conference, :Formal, :Cocktail, :Concert]

  #Validations ... self-explanatory, but number is no less than 8 (smallest number possible), but given the freedom to go further if they add spaces etc
  validates :business_name, presence: true
  validates :number, length: { minimum: 8 }, format: { with: /[0-9]/, message: "Only allows numbers and area codes" }
  validates :address, presence: true
  validates :about, presence: true
  validates :image, presence: true
end

