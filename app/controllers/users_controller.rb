class UsersController < ApplicationController 
  before_filter :authenticate_user!
  
  def index
    @users = User.search_for_user(params).page(params[:page]).per_page(10) #search is an intersection not union
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
      flash[:notice] = 'Account successfully updated.'
      redirect_to after_sign_in_path_for(current_user)
    else
      render :action => 'edit'
    end
    
  end
  
  
  def change_role
    @user = User.find(params[:id])
    authorize! :change_role, @user
    @user.role = params[:new_role]
    if @user.save
      flash[:notice] = "Successfully changed #{@user.first_name} #{@user.last_name}'s role to #{params[:new_role]}"
      redirect_to after_sign_in_path_for(current_user)
    else
      flash[:alert] = "Could not change #{@user.first_name} #{@user.last_name}'s  role to #{params[:new_role]}"
      render :action => 'edit'
    end
  end
  
  def edit_password
    @user = User.find(params[:id])
    authorize! :update, @user
  end
  
  
  def update_password
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update_with_password(params[:user]) #devise helper method, prevents updating password without current password
      sign_in @user, :bypass => true
      redirect_to after_sign_in_path_for(@user)
    else
      render "edit_password"
    end
  end
end
