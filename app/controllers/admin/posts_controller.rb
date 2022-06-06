class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comments = @post.post_comments.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def search
    @posts = Post.search(params[:search])
  end

end
