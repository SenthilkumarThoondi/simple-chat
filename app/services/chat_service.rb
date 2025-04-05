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
      create_chat_users(chat.id, [user_id, @current_user.id])
      chat
    else
      chat.errors.full_messages
    end
  end

  def create_group_chat(params)
    user_ids = params[:user_ids].reject(&:blank?) + [@current_user.id]
    chat = Chat.new(params.except(:user_ids))
    if chat.save
      create_chat_users(chat.id, user_ids.uniq)
      chat
    else
      chat.errors.full_messages
    end
  end

  def join_new_user(chat_id, user_ids)
    user_ids = user_ids.reject(&:blank?)
    chat = Chat.find_by(id: chat_id)
    return unless chat.present?

    create_chat_users(chat_id, user_ids)
    chat
  end

  def remove_user(params)
    chat = Chat.find_by(id: params[:id])
    return unless chat.present?

    chat.chat_users.find_by(id: params[:chat_user_id]).update(active: false)
    chat
  end

  private

  def create_chat_users(chat_id, user_ids)
    joined_at = Time.current
    chat_users_data = user_ids.map do |user_id|
      { chat_id: chat_id, user_id: user_id, joined_at: joined_at, role: (user_id == @current_user.id ? 2 : 0) }
    end

    ChatUser.insert_all(chat_users_data)
  end
end
