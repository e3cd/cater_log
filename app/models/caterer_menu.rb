class CatererMenu < ApplicationRecord
  #Associations
  belongs_to :user
  before_save :is_deleted_false

  #Validations
  validates :description, presence: true
  validates :price, format: { with: /[0-9]/, message: "Please enter amount with numbers" }

  def is_deleted_false
    self.is_deleted ||= false
  end

  #Remove all deleted records
  def self.current_records
    self.where(is_deleted: false)
  end
end
