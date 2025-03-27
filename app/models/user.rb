# frozen_string_literal: true

# this model for user
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages

  validates :username, presence: true

  def profile_image
    if avatar.attached?
      avatar
    else
      'avatar.png'
    end
  end
end
