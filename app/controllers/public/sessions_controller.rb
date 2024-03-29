# frozen_string_literal: true
class Public::SessionsController < Devise::SessionsController
  before_action:user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user.id), notice: "ゲストでログインしました。"
  end
  
  def destroy
    reset_guest_data if current_user.email == 'guest@example.com'
    super
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected

  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if @user.nil?
    return unless @user.valid_password?(params[:user][:password])

    if @user == false
        redirect_to :new_user_session
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
