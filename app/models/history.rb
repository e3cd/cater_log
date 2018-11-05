class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
  before_save :has_paid_false

  def has_paid_false
    self.has_paid ||= false
  end
end
