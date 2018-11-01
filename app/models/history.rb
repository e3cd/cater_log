class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
end
