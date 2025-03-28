# frozen_string_literal: true

# this model for chat
class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
  has_many :messages, dependent: :destroy

  scope :private_chat, -> { where(is_group: false) }
  scope :between, lambda { |user1, user2|
    joins(:chat_users)
      .where(chat_users: { user_id: [user1, user2] })
      .group('chats.id')
      .having('COUNT(DISTINCT chat_users.user_id) = 2')
  }

  def display_name(current_user)
    is_group? ? name : users.excluding(current_user).first&.username || 'Unknown Chat'
  end

  def display_image(current_user)
    is_group? ? 'group-avatar.png' : users.excluding(current_user).first&.profile_image
  end

  def admin
    chat_users.find_by(role: 1)&.user
  end

  def owner
    chat_users.find_by(role: 2)&.user
  end
end
