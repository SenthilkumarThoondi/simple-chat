# frozen_string_literal: true

# this controller for message related actions
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat
  def index
    @messages = @chat.messages
    @message = Message.new
  end

  def create
    @message = @chat.messages.new(message_params)
    if @message.save
      redirect_to chat_messages_path(@chat)
    else
      render :index
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :sender_id)
  end
end
