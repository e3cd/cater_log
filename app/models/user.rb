class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :caterer_menus
  has_many :messages
  has_many :conversations
  has_many :event_users
  has_one :caterer_information
         
end
