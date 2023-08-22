class BooksController < ApplicationController


  def create
    @user = User.new(post_image_params)
    @user.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @users = current_user
    @user = User.new
  end

  private

  def books_params
    params.require(:books).permit(:name, :introduction)
  end

end
