module Api
  module V1
    class ProposalsController < ApplicationController
      before_filter :load_conference
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def search
        @proposals = @conference.proposals.where(proposal_search)
        render json: @proposals
      end

      private
        def proposal_search
          {status: params[:status]}
        end

        def load_conference
          @conference = Conference.find_by(conference_year: params[:id])
        end
    end
  end
end