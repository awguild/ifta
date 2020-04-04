module Api
  module V1
    class SlotsController < ApplicationController
      skip_before_action :verify_authenticity_token
      respond_to :json

      def update
        authorize! :edit, @conference
        @slot = Slot.find(params[:id])
        if @slot.update_attributes(slot_params)
          render json: @slot, status: :ok
        else
          render json: @slot.errors, status: :unprocessable_entity
        end
      end

      private
        def slot_params
          params.permit(:proposal_id, :room_id, :code, :comments)
        end
    end
  end
end
