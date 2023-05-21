class Room < ApplicationRecord
  validates :name, presence: true
  validates :estimates, presence: true

  has_many :user_room_relationships, dependent: :destroy
  has_many :users, through: :user_room_relationships

  belongs_to :owner, class_name: 'User'
  
  def add_user(user)
    UserRoomRelationship.create(room: self, user: user)
  end

  def self.search(search)
    search ? Room.where("lower(name) LIKE ?", "%#{search.downcase}%") : Room.order(:name)
  end
end
