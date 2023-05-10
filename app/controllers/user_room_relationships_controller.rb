class UserRoomRelationshipsController < ApplicationController
  def toggle_hidden
    user_room_relationship = UserRoomRelationship.find_by(user_id: params[:user_id], room_id: params[:room_id])

    return if user_room_relationship.hidden == params[:hide]

    user_room_relationship.update(hidden: params[:hide])

    room = Room.find(params[:room_id])
    
    update_room_content(room)

    update_turbo(
      channel: "room_#{params[:room_id]}",
      partial: "rooms/hidden_users",
      locals: { room: room },
      target: "hidden_users_room_#{params[:room_id]}"
    )
  end
end
