class RoomsController < ApplicationController
	def index		
	    @conference = Conference.find(params[:conference_id])
	    @schedule = @conference.schedule
	    @rooms = @schedule.rooms
	    authorize! :edit, @schedule
        respond_to do |format|
            format.html #index.html.erb
            format.json { render json: @rooms}
        end
	end
end
