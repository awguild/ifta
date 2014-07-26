class IftaMember < ActiveRecord::Base
  attr_accessible :email
  
  #associaitons
  has_one :user, primary_key: 'email', foreign_key: 'ifta_member_email'

  #validations
  validates :email, :uniqueness => true

  def self.add_new_members(raw_emails)
    create(emails_to_members_array(raw_emails))
  end

  def self.replace_all_members_with(raw_emails)
    delete_all
    add_new_members(raw_emails)
  end


  private

  #first takes all of the raw emails and splits them on a comma followed by any number of whitespaces
  #then takes that array of email addresses and makes each one a hash that could be used to create a member
  #returns the array of all of those hashes
  def self.emails_to_members_array (raw_emails)
    raw_emails = raw_emails.strip.downcase
    raw_emails.split(/[\s]*[\,\s]+[\s]*/).uniq.map { |email| {:email => email}}
  end
end
