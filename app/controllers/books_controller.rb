class BooksController < ApplicationController
  before_action :ensure_correct_user,only: [:edit, :update]
  before_action :favorites_order, only: [:index]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.find(@order_array).sort_by{ |o| @order_array.index(o.id)} 
    @book = Book.new
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully destroyed'
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def favorites_order
    array = []
    Book.all.each do |item|
      array << [item.id, Favorite.where(book_id: item.id, created_at: 7.days.ago..Time.current).count]
    end
    array.sort! {|a,b| b[1] <=> a[1]}
    @order_array = array.map{|item| item[0]}
  end
 

end
