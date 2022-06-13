class Public::RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    redirect_to user_path(User.find(params[:id]))
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to user_path(User.find(params[:id]))
  end
end
