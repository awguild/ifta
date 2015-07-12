module Api
  module V1
    class SlotsController < ApplicationController
      before_filter :load_conference
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        authorize! :edit, @conference
        @slots = @conference.schedule.slots.includes([:proposal, :room])
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

      private
        def load_conference
          @conference = Conference.find_by(conference_year: params[:conference_id])
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