class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(liked_post_id: params[:liked_post_id])
    @like.save
    @post = @like.liked_post
    @likes = @post.likes.size
    respond_to do |format|
      format.html {redirect_to request.referrer || root_path}
      format.js
    end

  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.liked_post
    if @like.liker == current_user
      @like.destroy
    end
    respond_to do |format|
      format.html {redirect_to request.referrer || root_path}
      format.js
    end
  end

end
