class User < ApplicationRecord
  #### Validations - Email and password are covered by Devise #####
  validates :first_name, presence: true
  validates :last_name, presence: true
  #### End Validations #####

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  ##### Stripe User Callback ######
  
  # after_create_commit :add_stripe_charge_id

  ##### End Stripe User Callback ######

  ##### Associations ######
  has_many :reviews
  has_many :caterer_menus
  has_many :messages
  has_many :conversations
  has_many :histories
  has_one :caterer_information
  ##### End Associations #####

  ####### OmniAuth  ###########
  # Below was breaking the app, but I think its essential
  # @user = User.from_omniauth(request.env["omniauth.auth"])

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  #### END OMNI #########

  ### ADD STRIPE ID TO USER WHEN SIGNED UP ###

#   def add_stripe_charge_id
#     if self.stripe_charge_id.nil?
#       customer = Stripe::Customer.create(
#     :email => self.email
#   )
#   self.stripe_id = customer.id
#   self.save
#   end
# end
end