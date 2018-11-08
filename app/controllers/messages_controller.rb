class MessagesController < ApplicationController
  before_action :find_conversation

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
    @caterer = User.find(Conversation.find(params[:conversation_id]).caterer_id)
    
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def new
    @message = @conversation.messages.new
  end


  private

    def message_params
      params.require(:message).permit(:content, :user_id)
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end