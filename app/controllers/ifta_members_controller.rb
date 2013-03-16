class IftaMembersController < ApplicationController
  
  def mass_new
    authorize! :update, IftaMember
  end
  
  def complete_members_list
    authorize! :update, IftaMember
    #TODO replace all takes forever, it should be a background process with delayed_job 
    #but I had issues with setting up monit to monitor dealyed_job so the minute of app downtime is perferable
    IftaMember.replace_all_members_with(params[:raw_emails])  
    flash[:notice] = "Updating members list."
    redirect_to conference_path(Conference.active)
  end
  
  def add_to_members_list
    authorize! :update, IftaMember
    IftaMember.add_new_members(params[:raw_emails])
    flash[:notice] = "Members have been successfully added."
    redirect_to conference_path(Conference.active)
  end
end
