class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if post.save
      post.save_tag(tag_list)
      flash[:success] = "Submitted successfully."
      redirect_to post_path(post.id)
    else
      flash[:danger] = "Submission Failure."
      redirect_to new_post_path
    end
  end

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

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if post.update(post_params) #タグリスト更新
      old_relations = PostTag.where(post_id: post.id)
      old_relations.each do |relation|  #保存されていたタグを一旦削除し、保存し直す
        relation.delete
      end
      post.save_tag(tag_list)
      flash[:success] = "Editing Success."
      redirect_to post_path(post)
    else
      flash[:danger] = "Editing Failure."
      redirect_to edit_post_path(post)
    end
  end

  def destroy
  post = Post.find(params[:id])
  post.destroy
  redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end

end
