module Api
  module V1
    class RoomsController < ApplicationController
      before_filter :set_room, only: [:show, :update, :destroy]
      before_filter :find_conference, only: [:index, :create]
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        @rooms = @conference.rooms
        authorize! :edit, @conference
        render json: @rooms
      end

      def create
        @room = Room.new room_params
        @room.schedule = @conference.schedule

        authorize! :create, @room
        if @room.save
          head :created
        else
          render json: @room.errors, status: :unprocessable_entity
        end

      end

      def update
        authorize! :update, @room
        if @room.update_attributes(room_params)
          head :no_content
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @room

        @room.destroy
        head :no_content
      end

      private

      def set_room
        @room = Room.find(params[:id])
      end

      def find_conference
        @conference = Conference.find_by!(conference_year: params[:conference_id])
      end

      def room_params
        params.require(:room).permit(:label, :audio, :video)
      end
    end
  end
end
