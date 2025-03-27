# frozen_string_literal: true

# this migration for creating message_recipients table
class CreateMessageRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :message_recipients do |t|
      t.references :message, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.datetime :read_at

      t.timestamps
    end
  end
end
