# frozen_string_literal: true

# this model for chat
class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
end
