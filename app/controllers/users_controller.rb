class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @conference = selected_conference
    @conference_items = @conference.conference_items
    @users = User.search_for_user(params).includes(:line_items).page(params[:page]).per_page(150) #search is an intersection not union
    authorize! :list, User
  end

  def edit
    #I redirected the devise edit route (which doesn't put the user id in the URL) to this action,
    #fall back on current_user
    @user = User.find(params[:id] || current_user.id)
    authorize! :update, @user
  end


  def update
    @user = User.find(params[:id] || current_user)
    authorize! :update, @user

    if @user.update_attributes(user_params)
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
    if @user.update_with_password(user_params) #devise helper method, prevents updating password without current password
      sign_in @user, :bypass => true
      redirect_to after_sign_in_path_for(@user)
    else
      render "edit_password"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me,
        :first_name, :last_name, :prefix, :initial, :suffix, :address,
        :city, :state, :country_id, :zip, :phone, :username, :member,
        :student, :ifta_member_email, :fax_number, :emergency_name,
        :emergency_relationship, :emergency_telephone, :emergency_email,
        :nametag_name, :certificate_name)
    end
end
