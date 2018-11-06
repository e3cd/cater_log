class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
  before_save :has_paid_false

  def has_paid_false
    self.has_paid ||= false
  end

  #### Validations #####
  validates :first_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_date :booking_date, :on_or_after => :today 
  ## Not sure of wording for n.years... trying to stop them choosing a date 2 years in the future ##
  validates_date :booking_date, :on_or_before => lambda { 2.years }
  validates :number_of_heads, numericality: { only_integer: true, greater_than: 10, less_than: 200 }
  #### End Validations ####
end
