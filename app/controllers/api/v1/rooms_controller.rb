module Api
  module V1
    class RoomsController < ApplicationController
      before_filter :set_room, only: [:show, :update, :destroy]
      before_filter :find_conference, only: [:index, :create]
      respond_to :json

      def index
        @conference = Conference.find_by_conference_year(params[:conference_id])
        @rooms = @conference.rooms
        authorize! :edit, @conference
        render json: @rooms
      end

      def create
        @room = Room.new params[:room]
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
        if @room.update_attributes(params[:room])
          head :no_content
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @room.destroy

        authorize! :destroy, @room
        head :no_content
      end

      private

      def set_room
        @room = Room.find(params[:id])
      end

      def find_conference
        @conference = Conference.find_by_conference_year!(params[:conference_id])
      end
    end
  end
end
