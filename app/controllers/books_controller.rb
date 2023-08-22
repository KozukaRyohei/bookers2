class BooksController < ApplicationController


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
       render :new #未変更
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
