class SearchController < ApplicationController
  before_action :authenticate_user!

  def search

    if params[:search].present?
      @word = params[:search]
      if params[:model_name] == "1"
        @users = User.search(params[:search_method], params[:search])
      else
        @books = Book.search(params[:search_method], params[:search])
      end
    else
      @users = User.all
    end
  end


end
