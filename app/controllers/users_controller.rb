class UsersController < ApplicationController
  before_action :ensure_correct_user,only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else 
      render template: 'books/index'
    end
  end

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have created user successfully."
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end
    
    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
    end 
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
