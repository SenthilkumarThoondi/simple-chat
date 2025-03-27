# frozen_string_literal: true

# this migration for creating messages table
class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :chat, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
