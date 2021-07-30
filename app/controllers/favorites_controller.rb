class FavoritesController < ApplicationController

  def create 
    @book = Book.find(params[:book_id]) 
    favorite = current_user.favorites.build(book_id: @book.id) 
    favorite.save
    render :index
  end 

   

  def destroy 
    @book = Book.find(params[:book_id]) 
    favorite = current_user.favorites.find_by(book_id: @book.id) 
    favorite.destroy 
    render :index
    
  end 

end
