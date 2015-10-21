class PresenterProposalsQuery
  def initialize(conference)
    @data = conference.presenters
    .order(:last_name)
    .includes(:proposal)
  end

  def each
    prev = nil
    @data.each do |presenter|
      current = "#{presenter.reverse_full_name} #{presenter.email}"
      yield presenter, (prev != current)
      prev = current
    end
  end
end
