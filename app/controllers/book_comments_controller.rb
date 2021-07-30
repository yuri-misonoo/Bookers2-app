class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    render :index
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    redirect_to request.referer
  end
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
