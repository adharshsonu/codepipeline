class PostsController < ApplicationController
  before_action :fetch_post, only: %w[show edit update destroy]

  def index
    @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 10)
  end

  def new
    @post = Post.new
    render 'form'
  end

  def create
    @post = Post.create(post_params.merge(user_id: current_user.id))

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      render 'posts/save'
    else
      flash[:error] = 'Post failed to create.'
      render 'posts/save'
    end
  end

  def show
    @comments = @post.comments
  end

  def edit
    render 'form'
  end

  def update
    @post.update_attributes(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully updated.'
      render 'posts/save'
    else
      flash[:error] = 'Post failed to update.'
      render 'posts/save'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def fetch_post
    @post = Post.find_by(id: params[:id])
  end
end
