class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
  has_one :review
  before_save :has_paid_false

  def has_paid_false
    self.has_paid ||= false
  end

  #### Validations #####
  validates :first_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_date :booking_date, :on_or_after => :today 
  validates_date :booking_date, :on_or_before => lambda { 180.days.from_now }
  validates :number_of_heads, numericality: { only_integer: true, greater_than: 10, less_than: 200 }
  #### End Validations ####
end

#### LIMIT ACCESS TO REVIEWS FOR IF CURRENT USER IS PRESENT IN REVIEW>USER_ID ##