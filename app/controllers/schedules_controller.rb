class SchedulesController < ApplicationController
  def show
    @schedule = Conference.find(params[:conference_id]).schedule
    authorize! :show, @schedule
  end
  
  def edit
    @schedule = Conference.find(params[:conference_id]).schedule
    authorize! :edit, @schedule
  end
  
  def update
    @schedule = Conference.find(params[:conference_id]).schedule
    authorize! :update, @schedule
    if @schedule.update_attributes params[:schedule]
      redirect_to after_sign_in_path_for(current_user), :notice => 'Schedule successfully updated'
    else
      render :action => 'edit'
    end
  end
end
