class CatererInformation < ApplicationRecord
  #Association to user_id and ability to upload image
  belongs_to :user
  mount_uploader :image, ImageUploader

  #Enums used for dropdown menu in rego form ... saved as enum in CatererInfo database
  enum type_of_event: [:Wedding, :Party, :Conference, :Formal, :Cocktail, :Concert]

  #Validations ... self-explanatory, but number is no less than 8 (smallest number possible), but given the freedom to go further if they add spaces etc
  validates :business_name, presence: true
  validates :number, length: { minimum: 8 }
  validates :address, presence: true
  validates :about, presence: true
  validates :image, presence: true
  

  ###### Removed this, as we can set a basic avatar, and its up to the customer to set their own later ######
  # validates :image, presence: true

end

