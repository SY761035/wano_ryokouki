class Admin::PostImagesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    # byebug
    @user = User.find(params[:user_show_id])
    @post_images = @user.post_images.page(params[:page]).per(15).order(created_at: :desc)
  end
  
  # コメント一覧表示
  def show
    @post_image = PostImage.find(params[:id])
    @post_comments = @post_image.post_comments
    @users = User.all
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    user_id = post_image.user_id
    post_image.destroy
    redirect_to admin_post_images_path(user_show_id:user_id), notice: "削除しました."
  end
end
