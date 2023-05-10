module RoomsHelper
  def estimate?(user, room)
    UserRoomRelationship.find_by(user: user, room: room).estimate.nil?
  end

  def user_estimate(user, room)
    UserRoomRelationship.find_by(user: user, room: room).estimate
  end
end
