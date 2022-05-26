class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if post.save
      post.save_tag(tag_list)
      flash[:notice] = "投稿できました！"
      redirect_to post_path(post.id)
    else
      render :new
    end

  end

  def index
    @posts = Post.all
    #@tag_lists = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
