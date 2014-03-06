class Proposal < ActiveRecord::Base
  attr_accessible :format, :category, :title, :short_description, :long_description, :student, :agree, :presenters_attributes, :no_equipment, :sound, :projector, :keywords, :language_english, :language_spanish, :language_portuguese
  
  has_paper_trail #object versioning, don't let the users delete yo data!
  
  has_many :presenters, :dependent => :destroy
  belongs_to :itinerary
  has_many :reviews
  delegate :user, :to => :itinerary
  delegate :conference, :to => :itinerary
  has_one :slot
  
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
  validates :format, :presence => true
  validates :category, :presence => true
  validates :title, :presence => true
  validates_associated :presenters
  validates :presenters, :length => {:maximum => 4, :message => 'the maximum number of presenters is 4'}
  validates :agree, :acceptance => {:accept => true}
  
  #accepts_nested_attributes_for :proposal_multimedia, allow_destroy: true
  accepts_nested_attributes_for :presenters, allow_destroy: true
  
  after_initialize :add_self_as_presenter, :if => "self.new_record? && presenters.length == 0"
  scope :current, ->(conference_id = Conference.active.id){ joins(:itinerary).select('proposals.*,itineraries.conference_id').joins('INNER JOIN conferences ON conferences.id = conference_id').where('conference_id = ?', conference_id)}
  #scope :unreviewed, lambda {where('proposals.id NOT IN (' + reviewed.select('proposals.id').to_sql + ')')}
  scope :unreviewed, where(:status => nil)
  scope :reviewed, joins(:reviews)
  scope :unslotted, joins("LEFT OUTER JOIN slots ON slots.proposal_id = proposals.id").where("slots.proposal_id IS NULL AND proposals.status='accept'")
  def keyword_options
return [["Abuse and Domestic Violence",
  [
    "Bullying",
    "Emotional Abuse",
    "Physical Abuse: Child, Partner, Elder"
  ]
],
["Consultation and Collaboration On:",
  [
    "Collaborative Care",
    "Community Issues and Systems",
    "Homelessness, Migration, Resettlement", 
    "Medical Issues and Systems"
  ]
],
["Education and Training of Therapists",             
  [
    "Educational Preparation",
    "Clinical Training",
    "Supervision",
    "Therapy and Personal Growth",
    "Program Development",
    "Systemic Theory"
  ]
],
["Family Development",
  [
    "Clinical Implications of Family Development",
    "Theories of Family Development and Clinical Interventions", 
    "Child Development and Its Implications",
    "Parenting"
  ]
],
["Legal Regulation of Therapy/Therapists",
  [
    "Certification, Licensure, Regulation Issues"
  ]
],
["Research: Evaluation of Therapy",
  [
    "Evidence Based Treatment",
    "Methodology",
    "Outcome Research",
    "Process Research",
    "State of Knowledge"
  ]
],
["Therapy",
  [  
    "Couple and Marital Therapy",
    "Family Therapy"
  ]
],
["Trauma and Healing",
  [  
    "Accident and Injury",
    "Natural Catastrophe",
    "Terrorism",
    "Torture",        
    "War/Political"   
  ]
],
["Other",
  [
    "Coaching",
    "Death Dying, Bereavement, Loss",
    "Divorce and Remarriage",
    "Legal Systems and Courts",
    "Mental Health and Illness",
    "Spirituality",
  ]
]]
end

def show_languages
  languages = ""
  languages += "English, " if language_english
  languages += "Spanish, " if language_spanish
  languages += "Portugese, " if language_portuguese
  languages.chomp(", ")
end
  
def self.accepted_and_unregistered(conference)
  report = {}
  conference.proposals.where(:status => 'accept').includes(:presenters).each do |proposal|
    proposal.presenters.each do |presenter|
      u = User.where(:email => presenter.email).first
      if u.blank?
        status = 'No User'
      else
        conference_registration = u.itineraries.where(:conference_id => conference).first.conference_items.where("name like ?", '%Conference%')
        conference_ids = conference_registration.collect(&:id)
        if conference_registration.blank?
          status = 'Not registered'
        elsif u.itineraries.where(:conference_id => conference).first.line_items.where("paid=? AND conference_item_id IN (?)", true, conference_ids).blank?
          status = 'Pending Registration'
        end
      end

      if !status.nil?
        report[proposal.id] ||= {:proposal_title => proposal.title, :accepted_on => proposal.updated_at, :presenters => []}
        report[proposal.id][:presenters] << {
          :first_name => presenter.first_name,
          :last_name => presenter.last_name,
          :email => presenter.email,
          :status => status
        }
      end
    end
  end
  return report
end

  private
  def add_self_as_presenter
      presenter_attributes = {
        first_name: user.first_name,
        last_name: user.last_name,
        home_telephone: user.phone,
        email: user.email
      }
      presenters.build(presenter_attributes)
  end
  
  def self.search(options)
    proposals = Proposal.current(options[:conference_id])
    #Requests to the proposals index controller should have a hash called query whose keys are the proposal statuses you want returned
    #default behavior is to return proposals with no status
    options[:query].blank? ? proposals.where('proposals.status IS NULL') : proposals.where('proposals.status IN (?)', options[:query].keys.join(", ").sub('_', ' '))
  end
 
end
