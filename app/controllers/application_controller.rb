# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def update_turbo(channel:, partial:, locals:, target:)
    Turbo::StreamsChannel.broadcast_update_to(channel, partial:, locals:, target:)
  end

  def update_room_content(room)
    update_turbo(
      channel: "room_#{room.id}",
      partial: 'rooms/content',
      locals: { room:, owner: false },
      target: "room_content_#{room.id}"
    )

    update_turbo(
      channel: "room_owner_#{room.id}",
      partial: 'rooms/content',
      locals: { room:, owner: true },
      target: "room_content_#{room.id}"
    )
  end
end
