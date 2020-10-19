class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def create
    @book = Book.find(params[:book_id])
    @newbook = Book.new
    @user = @book.user
    @comments = @book.comments
    @newcomment = current_user.comments.new(comment_params)
    @newcomment.book_id = @book.id
    if @newcomment.save
      flash[:notice] = "successfully"
      redirect_back(fallback_location: books_path)
    else
      render("books/show")
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], book_id: params[:book_id])
    comment.destroy
    redirect_to book_path(params[:book_id])
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
   def correct_user
     @comment = Comment.find(params[:id])
     if current_user.id != @comment.user_id      
      redirect_to books_path    
     end
   end
  
end
