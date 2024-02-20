class Public::TagsearchesController < ApplicationController

  def search
    @model = PostImage  #search機能とは関係なし
    @word = params[:content]
    @page = params[:page]
    @post_images = PostImage.where("category LIKE?","%#{@word}%").page(@page)
    render "public/post_images/index"
  end

end
