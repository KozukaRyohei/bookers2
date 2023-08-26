class UsersController < ApplicationController

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render:edit
    end
  end

private

  def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path
      end
  end

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end