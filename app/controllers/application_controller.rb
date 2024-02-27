class ApplicationController < ActionController::Base

  def reset_guest_data
    guest_user = User.find_by(email: 'guest@example.com')
    guest_user.post_images.destroy_all if guest_user.post_images.any?
    guest_user.post_comments.destroy_all if guest_user.post_comments.any?
    guest_user.favorites.destroy_all if guest_user.favorites.any?
  end

end
