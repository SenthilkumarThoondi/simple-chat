# frozen_string_literal: true

# this migration for creating chat_users table
class CreateChatUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_users do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :joined_at
      t.datetime :left_at
      t.boolean :active, default: true
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
