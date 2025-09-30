class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = @post.comments.new
    render 'form'
  end

  def create
    @comment = Comment.create(comment_params.merge(user_id: current_user.id, post_id: @post.id))

    if @post.save
      flash[:notice] = 'Comment was successfully created.'
      render 'comments/save'
    else
      flash[:error] = 'Comment failed to create.'
      render 'comments/save'
    end
  end

  def edit
    render 'form'
  end

  def update
    @comment.update_attributes(comment_params)

    if @comment.save
      flash[:notice] = 'Comment was successfully updated.'
      render 'comments/save'
    else
      flash[:error] = 'Comment failed to update.'
      render 'comments/save'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
  end
end
