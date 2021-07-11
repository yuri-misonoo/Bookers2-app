class BooksController < ApplicationController



  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(params[:id])
  end

  def show
    @new_book = Book.new
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
