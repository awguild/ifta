class ReportsController < ApplicationController
	respond_to :html, :json

	def accepted_and_unregistered
		@conference = Conference.find(params[:id])
		authorize! :report, @conference
		@report = Proposal.accepted_and_unregistered(@conference)
	end

	def registration_breakdown
		@conference = Conference.find(params[:id])
		authorize! :report, @conference
		@report = @conference.registration_breakdown
		respond_with @report
	end
end
