class History < ApplicationRecord
  belongs_to :caterer_menu
  has_one :review
end
