class Proposal < ActiveRecord::Base
  attr_accessible :format, :category, :title, :short_description, :long_description, :student, :agree, :presenters_attributes, :no_equipment, :sound, :projector
  
  has_paper_trail #object versioning, don't let the users delete yo data!
  
  has_many :presenters
  belongs_to :itinerary
  delegate :user, :to => :itinerary
  
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
  validates :agree, :acceptance => {:accept => true}
  
  #accepts_nested_attributes_for :proposal_multimedia, allow_destroy: true
  accepts_nested_attributes_for :presenters, allow_destroy: true
  
  after_initialize :add_self_as_presenter, :if => "presenters.blank?"
  
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
  
end
