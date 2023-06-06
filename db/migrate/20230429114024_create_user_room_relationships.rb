# frozen_string_literal: true

class CreateUserRoomRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_room_relationships, id: :uuid do |t|
      t.string :estimate
      t.boolean :hidden, default: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :room, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
