class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
    @no_conversations = Conversation.no_conversations(current_user.id)
  end

  def create
    if Conversation.between(params[:customer_id], params[:caterer_id]).present?
      @conversation = Conversation.between(params[:customer_id], params[:caterer_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:customer_id, :caterer_id)
    end
    
end