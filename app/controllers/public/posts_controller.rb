class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:success] = "Submitted successfully."
      redirect_to post_path(post.id)
    else
      #flash.now[:danger] = "投稿に失敗しました"
      redirect_to new_post_path
      #render :new
    end

  end

  def index
    @posts = Post.all
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
  post = Post.find(params[:id])
  post.destroy
  redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :tag_list)
  end

end
