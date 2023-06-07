# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.search(params[:search])
  end

  def show
    @room = Room.find_by_id(params[:id])

    if @room.nil?
      redirect_to rooms_path, alert: 'Something went wrong'
      return
    end

    return if UserRoomRelationship.find_by(room: @room, user: current_user)

    @room.add_user(current_user)

    update_room_content(@room)
  end

  def new
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    room = Room.find(params[:id])

    if room.update(room_params)
      redirect_to room_path(room), notice: 'Successfully updated!'

      update_turbo(
        channel: "room_#{room.id}",
        partial: 'rooms/header',
        locals: { room:, user: current_user },
        target: "room_header_#{room.id}"
      )
    else
      redirect_to edit_room_path(room), alert: 'Something went wrong'
    end
  end

  def create
    room = current_user.rooms.create(room_params.merge({ owner: current_user }))
    redirect_to room_path(room), notice: 'Successfully created!'
  end

  def destroy
    Room.find(params[:id]).destroy
    redirect_to rooms_path, notice: 'Successfully deleted!'
  end

  def exit_room
    current_user.user_room_relationships.find_by(room_id: params[:room_id]).destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          :my_rooms,
          partial: 'users/my_rooms',
          locals: { rooms: current_user.rooms }
        )
      end
    end

    update_room_content(Room.find(params[:room_id]))
  end

  private

  def room_params
    params.require(:room).permit(:estimates, :name)
  end
end
