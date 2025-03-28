# frozen_string_literal: true

# this service for chat related business logics
class ChatService
  def initialize(current_user)
    @current_user = current_user
  end

  def create_new_chat(user_id)
    chat = Chat.between(@current_user.id, user_id).first_or_initialize
    return chat unless chat.new_record?

    if chat.save
      create_chat_users(chat, [user_id, @current_user.id])
      chat
    else
      chat.errors.full_messages
    end
  end

  def create_group_chat(params)
    user_ids = params[:user_ids].reject(&:blank?) + [@current_user.id]
    chat = Chat.new(params.except(:user_ids))
    if chat.save
      create_chat_users(chat, user_ids.uniq)
      chat
    else
      chat.errors.full_messages
    end
  end

  private

  def create_chat_users(chat, user_ids)
    joined_at = Time.current
    chat_users_data = user_ids.map do |user_id|
      { chat_id: chat.id, user_id: user_id, joined_at: joined_at, role: (user_id == @current_user.id ? 2 : 0) }
    end

    ChatUser.insert_all(chat_users_data)
  end
end
