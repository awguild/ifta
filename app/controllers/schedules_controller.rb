class SchedulesController < ApplicationController
  def show
    @conference = Conference.find(params[:conference_id])
    @schedule = @conference.schedule
    @slots = @schedule.slots.includes([:proposal, :room, {:time_slot => :day}])
    @rooms = @conference.rooms
    authorize! :show, @schedule
  end

  def edit
    @conference = Conference.find(params[:conference_id])
    @schedule = @conference.schedule
    authorize! :edit, @schedule
  end

  def update
    @conference = Conference.find(params[:conference_id])
    @schedule = @conference.schedule
    authorize! :update, @schedule
    if @schedule.update_attributes params[:schedule]
      redirect_to after_sign_in_path_for(current_user), :notice => 'Schedule successfully updated'
    else
      if params[:update_proposals]
            @slots = @schedule.slots
            @rooms = @conference.rooms
            render :action => 'show'
      else
        render :action => 'edit'
      end
    end
  end
end
