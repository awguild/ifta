class UsersController < ApplicationController 
  before_filter :authenticate_user!
  
  def index
    @users = User.search_for_user(params)
    authorize! :list, User
  end
  
  def edit
    #I redirected the devise edit route (which doesn't put the user id in the URL) to this action, 
    #fall back on current_user
    @user = User.find(params[:id] || current_user)
    authorize! :update, @user
  end
  
  
  def update
    @user = User.find(params[:id] || current_user)
    authorize! :update, @user
    
    if @user.update_attributes(params[:user])
      redirect_to after_sign_in_path_for(current_user), :notice => 'User successfully updated.'
    else
      render :action => 'edit'
    end
    
  end
  
end
