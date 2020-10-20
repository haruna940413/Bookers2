class RelationshipsController < ApplicationController 
  
  def index_following_user 
    @user  = User.find(params[:id])  
    @users = @user.following_user
  end  

  def index_follower_user
    @user  = User.find(params[:id])  
    @users = @user.follower_user
  end  


  def create
    @user = User.find(params[:user_id])
    
    following = current_user.follow(@user.id)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: @user)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: @user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    
    following = current_user.unfollow(@user.id)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: @user)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: @user)
    end
  end
  
  private
   def relationship_params
     params.require(:relationship).permit(:followed_id)
   end
  
end
