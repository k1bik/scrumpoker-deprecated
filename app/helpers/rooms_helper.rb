module RoomsHelper
  def estimate?(user, room)
    UserRoomRelationship.find_by(user:, room:).estimate.nil?
  end

  def user_estimate(user, room)
    UserRoomRelationship.find_by(user:, room:).estimate
  end
end
