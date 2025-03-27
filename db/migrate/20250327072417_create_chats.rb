# frozen_string_literal: true

# this migration for creating chats table
class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :name, null: true
      t.boolean :is_group, default: false

      t.timestamps
    end
  end
end
