class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
   @users = User.all
   @book = Book.new
   @user = current_user
  end

  def show
   @user = User.find(params[:id])
   @book = Book.new
   @books = @user.books
  end

  def new
   @user = User.new
  end

  def create
      @user = User.new(user_params)
    if @user.save
      flash[:notice] = "successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

protected
 def user_params
   params.require(:user).permit(:name, :email, :profile_image,:introduction)
 end
 
 def correct_user
   @user = User.find(params[:id])
   if current_user != @user    
    redirect_to user_path(current_user.id)
   end
 end
  
end
