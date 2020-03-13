# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:destroy]

  def index
    @comments = @commentable.comments
  end
  
  def new
    @comment = @commentable.comments.build
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @comment.commentable, notice: t("success.comment_was_successfully_created")
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t("success.comment_was_successfully_destroyed")
  end

  private
    def set_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
end
