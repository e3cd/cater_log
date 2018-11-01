class CatererInformation < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  enum type_of_event: [:Wedding, :Party, :Conference, :Formal, :Cocktail, :Concert]

  # enum event: {
  #   "Wedding": 1, 
  #   "Party": 2, 
  #   "Conference/Function": 3, 
  #   "Formal": 4,
  #   "Cocktail/Nibbles": 5,
  #   "Festival/Outdoor": 6
  # }

end

