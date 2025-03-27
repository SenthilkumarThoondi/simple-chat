# frozen_string_literal: true

# this model for message_recipient
class MessageRecipient < ApplicationRecord
  belongs_to :message
  belongs_to :user

  enum status: {
    sent: 0,
    received: 1,
    read: 2
  }

  validates :message_id, uniqueness: { scope: :user_id }
end
