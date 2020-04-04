module Api
  module V1
    class ProposalsController < ApplicationController
      before_action :load_conference
      skip_before_action :verify_authenticity_token
      respond_to :json

      def search
        @proposals = @conference.proposals.accepted.includes(:slot).where({slots: {proposal_id: nil}})
        render json: @proposals
      end

      def presenters
        @presenters = ProposalPresenters.exec(@conference.id)
        render json: @presenters
      end

      def formats
        @formats = @conference.proposals.pluck(:format).uniq
        render json: @formats
      end

      private

        def load_conference
          @conference = Conference.find_by(conference_year: params[:conference_id])
        end
    end
  end
end
