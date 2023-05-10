class CreateUserRoomRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_room_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
