# frozen_string_literal: true

# this model for chat_user
class ChatUser < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  enum role: {
    member: 0,
    admin: 1,
    owner: 2
  }

  validates :joined_at, presence: true
  validates :role, presence: true

  before_update :update_active_status, if: -> { will_save_change_to_left_at? }

  private

  def update_active_status
    self.active = left_at.nil?
  end
end
