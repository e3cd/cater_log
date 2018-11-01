class History < ApplicationRecord
  belongs_to :caterer_menu
  belongs_to :user
  has_one :review
end
