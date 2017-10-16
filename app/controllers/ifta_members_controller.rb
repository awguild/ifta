class IftaMembersController < ApplicationController

  def index
    authorize! :list, IftaMember
    @members = IftaMember.all
  end

  def mass_new
    authorize! :update, IftaMember
  end

  def complete_members_list
    authorize! :update, IftaMember
    IftaMember.replace_all_members_with(params[:raw_emails])
    flash[:notice] = "Members list has been successfully replaced."
    redirect_to after_sign_in_path_for(current_user)
  end

  def add_to_members_list
    authorize! :update, IftaMember
    IftaMember.add_new_members(params[:raw_emails])
    flash[:notice] = "Members have been successfully added."
    redirect_to after_sign_in_path_for(current_user)
  end
end
