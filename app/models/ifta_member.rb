class IftaMember < ActiveRecord::Base
  #associaitons
  has_one :user, primary_key: 'email', foreign_key: 'ifta_member_email'

  #validations
  validates :email, :uniqueness => { :case_sensitive => false }

  #callbacks
  after_create :activate_matching_user
  after_destroy :deactivate_matching_user

  def self.add_new_members(raw_emails)
    create(emails_to_members_array(raw_emails))
  end

  def self.replace_all_members_with(raw_emails)
    delete_all
    import(emails_to_members_array(raw_emails))
    sync_all_user_member_status!
  end

  def self.sync_all_user_member_status!
    member_emails = pluck(:email)
    User.where(email: member_emails).update_all("member = TRUE, ifta_member_email = email")
    User.where.not(email: member_emails).where(member: true).update_all(member: false, ifta_member_email: nil)
  end


  private

  #first takes all of the raw emails and splits them on a comma followed by any number of whitespaces
  #then takes that array of email addresses and makes each one a hash that could be used to create a member
  #returns the array of all of those hashes
  def self.emails_to_members_array (raw_emails)
    raw_emails = raw_emails.strip.downcase
    raw_emails.split(/[\s]*[\,\s]+[\s]*/).uniq.map { |email| {:email => email}}
  end

  def activate_matching_user
    User.where("LOWER(email) = ?", email.downcase).update_all("member = TRUE, ifta_member_email = email")
  end

  def deactivate_matching_user
    User.where("LOWER(email) = ?", email.downcase).update_all(member: false, ifta_member_email: nil)
  end
end
