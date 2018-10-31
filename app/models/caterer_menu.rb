class CatererMenu < ApplicationRecord
    belongs_to :user
    has_many :histories
end
