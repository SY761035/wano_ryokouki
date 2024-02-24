class Admin::PostCommentsController < ApplicationController
  
  def destroy
    post_comment = PostComment.find(params[:id])
    post_image = post_comment.post_image
    post_comment.destroy
    redirect_to admin_post_image_path(post_image)
  end
    
end
