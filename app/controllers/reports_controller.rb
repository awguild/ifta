class ReportsController < ApplicationController
	respond_to :html, :json
	respond_to :csv, only: :registration_breakdown

	def accepted_and_unregistered
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@accepted_and_unregistered_report = Proposal.accepted_and_unregistered(@conference)
	end

	def registration_breakdown
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@conference_item_breakdown_report = @conference.registration_breakdown
		@registrations = RegistrationBreakdownQuery.exec(@conference.conference_year)
		
		respond_to do |format|
			format.html
			format.json { render json: @registrations }
			format.csv { render json: RegistrationBreakdownQuery.to_csv(@registrations) }
		end
	end

	def student_presentations
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@report = @conference.proposals.where(:student => true)
	end
end
