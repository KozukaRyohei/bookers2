class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
       render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book_new = Book.new
    @book =  Book.find(params[:id])
    @user = @book.user
  end

  def edit
    is_matching_user_book
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render:edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def is_matching_user_book
      book = Book.find(params[:id])
      unless book.user == current_user
        redirect_to books_path
      end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
