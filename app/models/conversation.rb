class Conversation < ApplicationRecord
  belongs_to :caterer, foreign_key: :caterer_id, class_name: "User"
  belongs_to :customer, foreign_key: :customer_id , class_name: "User"

  has_many :messages
  validates_uniqueness_of :customer_id, scope: :caterer_id


  # This scope validation takes the customer_id and caterer_id for the conversation and checks whether a conversation exists between the two ids because we only want two users to have one conversation.

  scope :between, -> (customer_id, caterer_id) do
    where("(conversations.customer_id = ? AND conversations.caterer_id = ?) OR (conversations.customer_id = ? AND conversations.caterer_id = ?)", customer_id, caterer_id, caterer_id, customer_id)
  end

  def self.no_conversations(current_id)
    self.find_by(caterer_id: current_id) == nil && self.find_by(customer_id: current_id) == nil
  end

end
