class ReportsController < ApplicationController
	def accepted_and_unregistered
		@conference = Conference.find(params[:id])
		@report = Proposal.accepted_and_unregistered(@conference)
	end
end
