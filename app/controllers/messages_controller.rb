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
      Turbo::StreamsChannel.broadcast_append_to(
        "chat_#{@chat.id}",
        target: 'messages',
        partial: 'messages/message',
        locals: { message: @message, class_names: 'message' }
      )

      Turbo::StreamsChannel.broadcast_replace_to(
        "user_#{current_user.id}",
        target: "message_#{@message.id}",
        partial: 'messages/message',
        locals: { message: @message, class_names: 'message message-sender' }
      )
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
