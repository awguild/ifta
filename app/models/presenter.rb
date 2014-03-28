class Presenter < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :home_telephone, :work_telephone, :fax_number, :email, :affiliation_name, :affiliation_position, :registered, :other_presentations, :other_emails
  belongs_to :proposal

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
end
