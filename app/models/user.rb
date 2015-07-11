class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associaiton
  has_many :itineraries
  has_many :transactions, :through => :itineraries
  has_many :line_items, :through => :transactions
  has_many :conference_items, :through => :line_items
  has_many :payments, :through => :transactions
  has_many :reviews, foreign_key: 'reviewer_id'
  belongs_to :country
  belongs_to :ifta_member, primary_key: 'email', foreign_key: 'ifta_member_email'

  #validations
  #NOTE: validations must be conditional :unless => new_record?
  #otherwise devise can't create user
  validates :first_name, :last_name, :phone, :nametag_name, :certificate_name, :country_id, :presence => true, :unless => 'new_record?'
  validates :ifta_member, :existence => true, :if => 'member'
  validates :emergency_name, :emergency_relationship, :emergency_telephone, :presence => true, :unless => 'new_record?'

  #life cycle hooks
  after_save :set_country_category #WARNING this un-drys category data from the country table

  # constants
  ROLES = %W[attendee reviewer admin]

  def country_id=(id)
    write_attribute(:country_id, id)
  end

  def self.search_for_user(options)
    options[:email] ||= ""
    options[:first_name] ||= ""
    options[:last_name] ||= ""
    where('email LIKE ? AND first_name LIKE ? AND last_name LIKE ?', options[:email] + "%", options[:first_name] + "%", options[:last_name] + "%")
  end

  def item_status(item)
    @sorted_items ||= sort_line_items
    return "Paid" if @sorted_items[:paid].include?(item.id)
    return "Pending" if @sorted_items[:unpaid].include?(item.id)
    return "--"
  end

  def item_comment(item)
    @item_comments ||= extract_line_item_comments
    return @item_comments[item.id]
  end

  def is_reviewer?
    role == 'reviewer'
  end

  def is_admin?
    role == 'admin'
  end

  def is_attendee?
    role == 'attendee'
  end

  def itinerary_by_conference_id(conference_id)
    itineraries.where(:conference_id => conference_id).first
  end

  private
  def set_country_category
    update_column(:country_category, Country.find(self.country_id).category) unless country_id.blank?
  end

  def sort_line_items
    sorted = {:paid => [], :unpaid => []}
    line_items.each do |line_item|
      if line_item.paid
        sorted[:paid] << line_item.conference_item_id
      else
        sorted[:unpaid] << line_item.conference_item_id
      end
    end
    return sorted
  end

  def extract_line_item_comments
    comments = {}
    line_items.each do |line_item|
      comments[line_item.conference_item_id] = line_item.comment
    end
    return comments
  end

end

