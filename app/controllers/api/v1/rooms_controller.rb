module Api
  module V1
    class RoomsController < ApplicationController
      before_action :find_room, only: [:update, :destroy]
      before_action :find_conference, only: [:index, :create]
      skip_before_action :verify_authenticity_token
      respond_to :json

      def index
        authorize! :edit, @conference
        @rooms = @conference.rooms
        authorize! :edit, @conference
        render json: @rooms
      end

      def create
        authorize! :edit, @conference
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
        if @room.update(room_params)
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

      def find_room
        @room = Room.find(params[:id])
      end

      def find_conference
        @conference = Conference.find_by!(conference_year: params[:conference_id])
      end

      def room_params
        params.permit(:label, :audio, :video)
      end
    end
  end
end
