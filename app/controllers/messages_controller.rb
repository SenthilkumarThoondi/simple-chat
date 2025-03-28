# frozen_string_literal: true

# this controller for message related actions
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat
  def index
    @messages = @chat.messages
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
