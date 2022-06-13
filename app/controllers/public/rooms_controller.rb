class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def create
    room = Room.create
    Entry.create(user_id: current_user.id, room_id: room.id)
    Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.page(params[:page]).order(created_at: :desc)
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first

  end

end
