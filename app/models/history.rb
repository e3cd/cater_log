class History < ApplicationRecord
  belongs_to :user
  belongs_to :caterer_menu
  has_one :review
  before_save :has_paid_false

  #### Validations #####
  validates :first_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_date :booking_date, :on_or_after => :today 
  validates_date :booking_date, :on_or_before => lambda { 180.days.from_now }
  validates :number_of_heads, numericality: { only_integer: true, greater_than: 10, less_than: 200 }
  #### End Validations ####

  def has_paid_false
    self.has_paid ||= false
  end

  def self.no_history(id)
    ###### SEE IF YOU CAN GET THIS UP AND RUNNING, CHECKING TO SEE IF USER'S CATERER MENUS EXIST IN THE HISTORIES DATABASE ######

    # if is_caterer
    #   record = []
    #   user_menus(id).each do |menu_id|
    #     record.push(self.find_by(caterer_menu: menu_id))  
    #   end
    #   !record.any?
    # else
      self.find_by(user_id: id) == nil
    # end
  end

  def self.user_menus(id)
    User.find(id).caterer_menus.collect {|menu| menu.id }
  end

  def self.any_review(history)
    history.review if history.review != nil
  end
end