module Api
  module V1
    class SlotsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def update
        @slot = Slot.find(params[:id])
        if @slot.update_attributes(slot_params)
          render json: @slot, status: :ok
        else
          render json: @slot.errors, status: :unprocessable_entity
        end
      end

      private
        def slot_params
          params.permit(:proposal_id, :room_id, :code, :comments, :start_time, :end_time)
        end
    end
  end
end