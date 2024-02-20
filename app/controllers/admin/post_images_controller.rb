class Admin::PostImagesController < ApplicationController
  def index
    # byebug
    @user = User.find(params[:user_show_id])
    @post_images = @user.post_images.page(params[:page]).per(15)
  end
  
  def show
    @post_comment = PostComment.find(params[:id])
  end
  
  def destroy
    @comment = PostComment.find(params[:id])
    @post_image = @comment.post_image
    @comment.destroy
    # redirect_to post_image_path(params[:post_image_id])
  end
end
