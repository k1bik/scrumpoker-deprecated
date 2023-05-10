class AddEstimateToUserRoomRelationship < ActiveRecord::Migration[7.0]
  def change
    add_column :user_room_relationships, :estimate, :string
  end
end
