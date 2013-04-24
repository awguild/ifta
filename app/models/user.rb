class User < ActiveRecord::Base
  has_paper_trail 
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :prefix, :initial, :suffix, :address, :city, :state, :country_id, :zip, :phone, :username, :member, :student, :ifta_member_email, :fax_number
  
  belongs_to :country
  has_many :transactions
  has_many :payments, :through => :transactions
  has_many :itineraries
  belongs_to :ifta_member, primary_key: 'email', foreign_key: 'ifta_member_email'
  has_many :reviews, foreign_key: 'reviewer_id'
  validates :first_name, :presence => true, :unless => 'new_record?'
  validates :last_name, :presence => true, :unless => 'new_record?'
  validates :phone, :presence => true, :unless => 'new_record?'
  validates :country_id, :presence => true, :unless => 'new_record?'
  validates :ifta_member, :existence => true, :if => 'member'
  
  #NOTE: if you want to set up validations make them conditional ... :unless => new_record? 
  #otherwise devise won't be able to create users
  
  after_save :set_country_category #WARNING this un-drys category data from the country table
  
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
  
  private
  def set_country_category  
    update_column(:country_category, Country.find(self.country_id).category) unless country_id.blank?
  end
  
  
end

