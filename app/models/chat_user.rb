# frozen_string_literal: true

# this model for chat_user
class ChatUser < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  enum role: {
    member: 0,
    admin: 1
  }

  validates :joined_at, presence: true
  validates :role, presence: true

  before_update :update_active_status

  private

  def update_active_status
    self.active = left_at.nil?
  end
end
