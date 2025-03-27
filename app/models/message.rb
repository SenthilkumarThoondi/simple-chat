# frozen_string_literal: true

# this model for message
class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :chat
  has_many :message_recipients
  has_many :recipients, through: :message_recipients, source: :user

  enum status: {
    sent: 0,
    received: 1,
    read: 2
  }

  validates_presence_of :content, :sender_id, :chat_id
end
