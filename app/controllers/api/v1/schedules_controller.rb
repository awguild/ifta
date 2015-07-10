module Api
  module V1
    class SchedulesController < ApplicationController
      before_filter :load_conference
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def show
        @slots = @conference.schedule.slots.includes([:proposal, :room])
        authorize! :show, @conference.schedule
        render json: @slots
      end

      private
        def load_conference
          @conference = Conference.find_by_conference_year(params[:conference_id])
        end
    end
  end
end