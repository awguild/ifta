class RoomsController < ApplicationController
	before_filter :set_room, only: [:show, :update, :destroy]

	def index
	    @conference = Conference.find(params[:conference_id])
	    @schedule = @conference.schedule
	    @rooms = @schedule.rooms
	    authorize! :edit, @schedule
        respond_to do |format|
            format.json { render json: @rooms}
        end
	end

    def show
        authorize! :show, @room
    end

    def create
        @room = Room.new params[:room]

        authorize! :create, @room

        respond_to do |format|
            if @room.save
                format.json { render action: 'show', status: :created, location: @room }
            else
                format.json { render json: @room.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        @room = Room.find(:id)

        authorize! :update, @room

        if @room.update_attributes(params[:room])
            format.json { head :no_content }
        else
            format.json { render json: @room.errors, status: :unprocessable_entity }
        end
    end

    def destroy
        @room.destroy

        authorize! :destroy, @room
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private

    def set_room
        @room = Room.find(params[:id])
    end
end
