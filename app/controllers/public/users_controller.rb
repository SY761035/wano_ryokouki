class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :correct_user,only: [:edit,:update]
  before_action :set_user, only: [:likes]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).per(15)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "更新に成功しました."
    else
      render :edit
    end
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to root_path #削除に成功すればrootページに戻る
  end

  def favorites
    likes = Favorite.where(user_id: params[:id]).pluck(:post_image_id)
    @post_images = PostImage.where(id: likes).page(params[:page]).per(15)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
        @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to users_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
