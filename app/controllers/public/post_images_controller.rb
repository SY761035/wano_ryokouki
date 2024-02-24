class Public::PostImagesController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :correct_post_image,only: [:edit,:update]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path, notice: "投稿に成功しました."
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page]).per(15)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image.id), notice: "更新に成功しました."
    else
      render :edit
    end
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path, notice: "削除しました."
  end

  private

  def correct_post_image
        @post_image = PostImage.find(params[:id])
    unless @post_image.user.id == current_user.id
      redirect_to post_images_path
    end
  end

  def post_image_params
    params.require(:post_image).permit(:event_name, :image, :caption, :genre_id, :category)
  end
end
