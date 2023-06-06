# frozen_string_literal: true

class AddOwnerToRoom < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :owner, foreign_key: { to_table: :users }, type: :uuid
  end
end
