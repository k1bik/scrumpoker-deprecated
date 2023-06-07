# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :estimates, null: false
      t.string :name, null: false
      t.boolean :show_estimates, default: false

      t.timestamps
    end
  end
end
