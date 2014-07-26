class ReportsController < ApplicationController
	respond_to :html, :json

	def accepted_and_unregistered
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@report = Proposal.accepted_and_unregistered(@conference)
	end

	def registration_breakdown
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@report = @conference.registration_breakdown
		respond_with @report
	end

	def student_presentations
		@conference = Conference.find_by_conference_year(params[:id])
		authorize! :report, @conference
		@report = @conference.proposals.where(:student => true)
	end
end
