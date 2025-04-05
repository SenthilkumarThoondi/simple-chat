# frozen_string_literal: true

# this controller for chat related actions
class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = current_user.chats.includes(:messages, :users)
  end

  def new
    @users = User.excluding(current_user)
    @chat = Chat.new
  end

  def new_group_chat
    @users = User.excluding(current_user)
    @group_chat = Chat.new
  end

  def show
    @chat = Chat.find_by(id: params[:id])
  end

  def new_user
    @chat = Chat.find_by(id: params[:id])
    selected_user_ids = @chat.users
    @users = User.excluding(selected_user_ids)
  end

  def create
    result = ChatService.new(current_user).create_new_chat(chat_params[:user_id])
    if result.is_a?(Chat)
      redirect_to chat_messages_path(result)
    else
      flash[:alert] = result.join(', ')
      redirect_to new_chat_path
    end
  end

  def create_group_chat
    result = ChatService.new(current_user).create_group_chat(group_chat_params)
    if result.is_a?(Chat)
      redirect_to chat_messages_path(result)
    else
      flash[:alert] = result.join(', ')
      redirect_to new_group_chat_path
    end
  end

  def join_new_user
    result = ChatService.new(current_user).join_new_user(params[:id], group_chat_params[:user_ids])
    if result.is_a?(Chat)
      redirect_to chat_messages_path(result)
    else
      flash[:alert] = result.join(', ')
      redirect_to new_user_chat_path
    end
  end

  def remove_user
    result = ChatService.new(current_user).remove_user(params)
    if result.is_a?(Chat)
      redirect_to chat_messages_path(result)
    else
      flash[:alert] = result.join(', ')
      redirect_to new_user_chat_path
    end
  end

  private

  def chat_params
    params.permit(:user_id)
  end

  def group_chat_params
    params.require(:chat).permit(:name, :is_group, user_ids: [])
  end
end
