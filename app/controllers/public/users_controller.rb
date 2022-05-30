class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @current_user_entry.each do |current_user_e|
        @user_entry.each do |user_e|
          if current_user_e.room_id == user_e.room_id then
            @is_room = true
            @room_id = current_user_e.room_id
          end
        end
      end
      if @is_room
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end

  def follow_lists

  end

  def follower_lists
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
