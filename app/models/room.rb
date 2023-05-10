class Room < ApplicationRecord
  has_many :user_room_relationships, dependent: :destroy
  has_many :users, through: :user_room_relationships

  belongs_to :owner, class_name: 'User'
  
  def add_user(user)
    UserRoomRelationship.create(room: self, user: user)
  end
end
