class Proposal < ActiveRecord::Base
  #object versioning, don't let the users delete yo data!
  has_paper_trail

  #associations
  has_many :presenters, :dependent => :destroy
  has_many :reviews
  belongs_to :itinerary
  belongs_to :conference
  belongs_to :user

  accepts_nested_attributes_for :presenters, allow_destroy: true

  #query
  scope :current, ->(conference_id = Conference.active.id){ joins('INNER JOIN conferences ON conferences.id = proposals.conference_id').where('conference_id = ?', conference_id)}
  scope :unreviewed, -> { where(:status => nil) }
  scope :reviewed, -> { joins(:reviews) }
  scope :accepted, -> { where(:status => 'accept') }
  scope :wait_listed, -> { where(:status => 'wait list') }

  #validations
  validate :short_description_max_words
  validate :long_description_max_words
  validates :format, :category, :title, :short_description, :relative_number, :itinerary, :conference, :learning_objective, :presence => true
  validates_associated :presenters
  validates :presenters, :length => {:maximum => 4, :message => 'the maximum number of presenters is 4'}
  validates :agree, :acceptance => {:accept => true}
  validate :check_av_requirements

  #life cycle hooks
  before_validation :add_relative_number

  def self.accepted_and_unregistered(conference)
    report = {}
    conference.proposals.where(:status => 'accept').includes(:presenters).find_each do |proposal|
      proposal.presenters.each do |presenter|
        report[proposal.id] ||= {
          :proposal_title => proposal.title,
          :accepted_on => proposal.updated_at,
          :presenters => []
        } # initialize each proposal once
        report[proposal.id][:presenters] << {
          :first_name => presenter.first_name,
          :last_name => presenter.last_name,
          :email => presenter.email,
          :status => Presenter.presenter_conference_status(presenter.email, conference.id)
        }
      end
    end
    return report
  end

  def add_self_as_presenter
    presenters.build({
      first_name: user.first_name,
      last_name: user.last_name,
      home_telephone: user.phone,
      email: user.email,
      country_id: user.country.id
    })
  end

  private

    def check_av_requirements
      if (projector.present? || sound.present?) && no_equipment.present?
        errors.add(:no_equipment, 'You cannot select no equipment with other options')
      end

      if no_equipment.blank? && projector.blank? && sound.blank?
        errors.add(:no_equipment, 'Please select one of the AV options.')
      end

      if format == '20min' && (projector.present? || sound.present?)
        errors.add(:format, '20 minutes does not allow AV equipment')
      end
    end

    def self.search(options)
      proposals = Proposal.current(options[:conference_id])
      #Requests to the proposals index controller should have a hash called query whose keys are the proposal statuses you want returned
      #default behavior is to return proposals with no status
      options[:query].blank? ? proposals.where('proposals.status IS NULL') : proposals.where('proposals.status IN (?)', options[:query].keys.join(", ").sub('_', ' '))
    end

    def self.next_relative_number(conference_id)
      proposal = where(conference_id: conference_id).where('relative_number IS NOT NULL').order('relative_number DESC').first
      (proposal.present? ? proposal.relative_number : 0) + 1
    end

    def add_relative_number
      self.relative_number = Proposal.next_relative_number(conference_id) if relative_number.blank?
    end

    def short_description_max_words
      count = short_description.scan(/\w+/).count
      if count  > 50
        errors.add(:short_description, "max words is 50 and you have #{count}")
      end
    end

    def long_description_max_words
      count = long_description.scan(/\w+/).count
      if count > 300
        errors.add(:long_description, "max words is 300 and you have #{count}")
      end
    end
end
