class User < ApplicationRecord
  #### Validations - Email and password are covered by Devise #####
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save :remove_whitespace
  before_save :capitalize_data
  #### End Validations #####

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  ##### Stripe User Callback ######
  
  after_create_commit :add_customer_id

  ##### End Stripe User Callback ######

  ##### Associations ######
  has_many :reviews
  has_many :caterer_menus
  has_many :messages
  has_many :conversations
  has_many :histories
  has_one :caterer_information
  ##### End Associations #####

  ##### MODEL SCOPE FOR CAPITALIZE #########
  def capitalize_data
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
  end
  ###### END MODEL SCOPE #######

  ##### MODEL SCOPE FOR FULL NAME #########
  def name
    "#{self.first_name} #{self.last_name}"
  end
  ###### END MODEL SCOPE #######

  ##### MODEL SCOPE FOR CATERER NAME #########
  def self.caterer_name(id)
    CatererInformation.find_by(user_id: id).business_name
  end
  ###### END MODEL SCOPE #######

  ## ADD STRIPE ID TO USER WHEN SIGNED UP ###
  def add_customer_id
    if self.customer_id.nil?
      customer = Stripe::Customer.create(:email => self.email)
      self.customer_id = customer.id
      self.save
    end
  end
  ###### END STRIPE ######

end