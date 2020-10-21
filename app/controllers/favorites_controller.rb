class FavoritesController < ApplicationController

  # def create
  #   book = Book.find(params[:book_id])
  #   favorite = current_user.favorites.new(book_id: book.id)
  #   favorite.save
  #   redirect_back(fallback_location: book)
  # end

  # def destroy
  #   book = Book.find(params[:book_id])
  #   favorite = current_user.favorites.find_by(book_id: book.id)
  #   favorite.destroy
  #   redirect_back(fallback_location: book)
  # end

  before_action :set_book

  def create
    @favorite = Favorite.create(user_id: current_user.id, book_id: @book.id)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id)
    @favorite.destroy
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end

end
