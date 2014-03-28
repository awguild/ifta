class RoomsController < ApplicationController
	def index
	    @conference = Conference.find(params[:conference_id])
	    @schedule = @conference.schedule
	    @rooms = @schedule.rooms
	    authorize! :edit, @schedule
	end
end
