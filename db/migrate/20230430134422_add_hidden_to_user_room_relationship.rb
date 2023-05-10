class AddHiddenToUserRoomRelationship < ActiveRecord::Migration[7.0]
  def change
    add_column :user_room_relationships, :hidden, :boolean, default: false
  end
end
