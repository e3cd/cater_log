class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
  ## access module using History.new.stripe
  include Payment
end
