class EstimatesController < ApplicationController
  def update
    user_room_relationship = UserRoomRelationship.find_by(room_id: params[:room_id], user: current_user)

    return if user_room_relationship.estimate == params[:estimate]

    if user_room_relationship.update(estimate: params[:estimate])
      update_turbo(
        channel: "room_#{params[:room_id]}",
        partial: "rooms/estimate",
        locals: { estimate: params[:estimate], room: Room.find(params[:room_id]), user: current_user },
        target: "estimate_room_#{params[:room_id]}_user_#{current_user.id}"
      )
    end

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.update(
          "room_header_#{params[:room_id]}",
          partial: "rooms/header",
          locals:  { room: Room.find(params[:room_id]), user: current_user }
        )
      end
    end

  end

  def toogle_estimates
    room = Room.find(params[:room_id])

    return if room.show_estimates == params[:show]

    room.update(show_estimates: params[:show])

    update_turbo(
      channel: "room_#{room.id}",
      partial: "rooms/content",
      locals: { room: room, sort: params[:show] },
      target: "room_content_#{room.id}"
    )

    update_turbo(
      channel: "room_#{params[:room_id]}",
      partial: "rooms/buttons",
      locals: { room: room },
      target: "room_buttons_#{params[:room_id]}"
    )
  end

  def reset_estimates
    room = Room.find(params[:room_id])
    room.user_room_relationships.update(estimate: nil)
    room.update(show_estimates: false)

    update_turbo(
      channel: "room_#{params[:room_id]}",
      partial: "rooms/header",
      locals: { room: room, user: current_user },
      target: "room_header_#{params[:room_id]}"
    )
    
    update_room_content(room)

    return if room.show_estimates

    update_turbo(
      channel: "room_#{params[:room_id]}",
      partial: "rooms/buttons",
      locals: { room: room },
      target: "room_buttons_#{params[:room_id]}"
    )
  end
end
