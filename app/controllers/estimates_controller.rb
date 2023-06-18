# frozen_string_literal: true

class EstimatesController < ApplicationController
  before_action :load_room

  def set_estimate
    room_id = params[:room_id]

    user_room_relationship = UserRoomRelationship.find_by(room_id:, user: current_user)

    return if user_room_relationship.estimate == params[:estimate]

    if user_room_relationship.update(estimate: params[:estimate])
      update_turbo(
        channel: "room_#{room_id}",
        partial: 'rooms/estimate',
        locals: { estimate: params[:estimate], room: @room, user: current_user },
        target: "estimate_room_#{room_id}_user_#{current_user.id}"
      )
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "room_header_#{room_id}",
          partial: 'rooms/header',
          locals: { room: @room, user: current_user }
        )
      end
    end
  end

  def toogle_estimates
    return if @room.show_estimates == params[:show]

    room_id = params[:room_id]

    @room.update(show_estimates: params[:show])

    update_turbo(
      channel: "room_#{room_id}",
      partial: 'rooms/content',
      locals: { room: @room, sort: params[:show], owner: false },
      target: "room_content_#{room_id}"
    )

    update_turbo(
      channel: "room_owner_#{room_id}",
      partial: 'rooms/content',
      locals: { room: @room, sort: params[:show], owner: true },
      target: "room_content_#{room_id}"
    )

    update_turbo(
      channel: "room_#{room_id}",
      partial: 'rooms/buttons',
      locals: { room: @room },
      target: "room_buttons_#{room_id}"
    )
  end

  def reset_estimates
    @room.user_room_relationships.update(estimate: nil)

    @room.update(show_estimates: false)

    room_id = params[:room_id]

    update_turbo(
      channel: "room_#{room_id}",
      partial: 'rooms/header',
      locals: { room: @room, user: current_user },
      target: "room_header_#{room_id}"
    )

    update_room_content(@room)

    return if @room.show_estimates

    update_turbo(
      channel: "room_#{room_id}",
      partial: 'rooms/buttons',
      locals: { room: @room },
      target: "room_buttons_#{room_id}"
    )
  end

  private

  def load_room
    @room = Room.find(params[:room_id])
  end
end
