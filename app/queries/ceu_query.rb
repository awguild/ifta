class CeuQuery
  HEADERS = [
    'First Name',
    'Last Name',
    'Email',
    'Country',
    'Presentation Format',
    'Title of Presentation',
    'Short Description',
    'Long Description',
    'Learning Objective',
    'Affiliation Name',
    'Affiliation Position',
    'Terminal or Highest Degree',
    'Graduating Institution',
    'What qualifies you to present on this topic',
  ]

  def initialize(conference)
    @conference = conference
  end

  def to_csv
    CSV.generate do |csv|
      csv << HEADERS

      presenters.find_each do |presenter|
        csv << row(presenter)
      end
    end
  end

  private

  def row(presenter)
    [
      presenter.first_name,
      presenter.last_name,
      presenter.email,
      presenter.country&.name,
      presenter.proposal.format,
      presenter.proposal.title,
      presenter.proposal.short_description,
      presenter.proposal.long_description,
      presenter.proposal.learning_objective,
      presenter.affiliation_name,
      presenter.affiliation_position,
      presenter.highest_degree,
      presenter.graduating_institution,
      presenter.qualifications

    ]
  end

  def presenters
    @presenters ||= @conference.presenters.group(:email).includes(:proposal, :country)
  end
end
