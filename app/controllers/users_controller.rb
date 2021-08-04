class UsersController < ApplicationController
  before_action :ensure_correct_user,only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @have_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @have_room
        @room = Room.new
        @entry = Entry.new
      end
    end
      
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
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
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end
    
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
