class ReportsController < ApplicationController
	respond_to :html, :json
	respond_to :csv, only: [:registration_breakdown, :presentations, :ceu]

  before_action :find_conference

	def accepted_and_unregistered

		authorize! :report, @conference
		@accepted_and_unregistered_report = Proposal.accepted_and_unregistered(@conference)
	end

	def registration_breakdown
		authorize! :report, @conference
		@conference_item_breakdown_report = @conference.registration_breakdown
		@proposals = @conference.proposals.accepted.includes(user: [:country]).order(:user_id)
    @paid_items = @conference.paid_items_by_user
	end

	def student_presentations
		authorize! :report, @conference
		@report = @conference.proposals.where(:student => true)
	end

	def presentations
		authorize! :report, @conference
		@presentations = PresentersQuery.exec(@conference.id)

		respond_to do |format|
			format.html
			format.json { render json: @presentations }
			format.csv { render json: PresentersQuery.to_csv(@presentations) }
		end
	end

  def presenter_proposals
    authorize! :report, @conference
    @presenter_proposals = PresenterProposalsQuery.new(@conference)

    respond_with(@presenter_proposals)
  end

  def ceu
    authorize! :report, @conference
    respond_to do |format|
      format.csv { render text: CeuQuery.new(@conference).to_csv }
    end
  end

  private

  def find_conference
    @conference = Conference.find_by(conference_year: params[:id])
  end
end
