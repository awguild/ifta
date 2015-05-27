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

      def update
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

      private
        def load_conference
          @conference = Conference.find_by_conference_year(params[:conference_id])
        end
    end
  end
end