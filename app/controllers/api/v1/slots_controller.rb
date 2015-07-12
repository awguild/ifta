module Api
  module V1
    class SlotsController < ApplicationController
      before_filter :load_conference
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        authorize! :edit, @conference
        @time_blocks = @conference.schedule.time_blocks.includes({slots: [{proposal: [{user: [:country]}, :presenters]}, :room]})
      end

      def create
        @slots = CreateSlotsApi.new(slots_params)
        if @slots.valid?
          @slots = @slots.persist!
          render json: @slots, status: :created
        else
          render json: @slots.errors, status: :unprocessable_entity
        end
      end

      def update
        @slot = Slot.find(params[:id])
        if @slot.update_attributes(slot_params)
          render json: @slot, status: :ok
        else
          render json: @slot.errors, status: :unprocessable_entity
        end
      end

      private
        def load_conference
          @conference = Conference.find_by(conference_year: params[:conference_id])
        end

        def slot_params
          params.permit(:proposal_id, :room_id, :code, :comments, :start_time, :end_time)
        end

        def slots_params
          {
            quantity: params[:quantity],
            start_time: params[:end_time],
            end_time: params[:end_time],
            schedule_id: @conference.schedule.id
          }
        end
    end
  end
end