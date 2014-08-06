class Proposal < ActiveRecord::Base
  attr_accessible :format, :category, :title, :short_description, :long_description, :student, :agree, :presenters_attributes, :no_equipment, :sound, :projector, :keywords
  attr_accessible :language_english, :language_spanish, :language_portuguese, :language_mandarin, :language_malay

  #object versioning, don't let the users delete yo data!
  has_paper_trail

  #associations
  has_many :presenters, :dependent => :destroy
  has_many :reviews
  has_one :slot
  has_one :room, :through => :slot
  belongs_to :itinerary
  belongs_to :conference
  belongs_to :user

  accepts_nested_attributes_for :presenters, allow_destroy: true

  #query
  scope :current, ->(conference_id = Conference.active.id){ joins('INNER JOIN conferences ON conferences.id = proposals.conference_id').where('conference_id = ?', conference_id)}
  scope :unreviewed, where(:status => nil)
  scope :reviewed, joins(:reviews)
  scope :unslotted, joins("LEFT OUTER JOIN slots ON slots.proposal_id = proposals.id").where("slots.proposal_id IS NULL AND proposals.status='accept'")
  scope :accepted, where(:status => 'accept')
  scope :wait_listed, where(:status => 'wait list')

  #validations
  validates :short_description, :length => {
    :maximum => 50,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long => "must have at most %{count} words"
  }
  validates :long_description, :length => {
    :maximum => 350,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long => "must have at most %{count} words"
  }
  validates :format, :category, :title, :relative_number, :itinerary, :conference, :presence => true
  validates_associated :presenters
  validates :presenters, :length => {:maximum => 4, :message => 'the maximum number of presenters is 4'}
  validates :agree, :acceptance => {:accept => true}

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
      email: user.email
    })
  end

  private

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
end
