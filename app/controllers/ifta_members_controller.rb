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
    #TODO replace_all_members_with takes a few seconds in MySQL (+1min in SQLite), it should really be a background process with delayed_job 
    #but I had issues setting up monit to monitor dealyed_job so the downtime is perferable to not knowing whether the update was successful
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
