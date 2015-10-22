module ReportsHelper

  def status_class(proposal)
    proposal.status.try(:underscore)
  end
end
