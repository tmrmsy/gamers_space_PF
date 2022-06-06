class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @current_entry = Entry.where(user_id: current_user.id)
      @another_entry = Entry.where(user_id: @user.id)
        unless @user.id == current_user.id
          @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        unless @is_room
          @room = Room.new
          @entry = Entry.new
        end
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

  def favorites
    favorites = Favorite.where(user_id: current_user).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
