class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(params_post)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = "投稿できました！"
      redirect_to post_path(post.id)
    else
      render :new
    end

  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  private

  def params_post
    params.require(:post).permit(:title, :content, :user_id)
  end
end
