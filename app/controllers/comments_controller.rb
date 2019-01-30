class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to request.referrer || root_path
    else
      if request.referrer == root_path
        render 'static_pages/home'
      else
        render @comment.post.author
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.author == current_user
      @comment.destroy
      flash[:success] = "Comment removed."
    end
    redirect_to request.referrer || root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
