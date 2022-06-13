class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
    @tag_list = Tag.all
    if params[:tag_id]
      tag = Tag.find(params[:tag_id])
      @posts = tag.posts.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).order(created_at: :desc)
  end

end
