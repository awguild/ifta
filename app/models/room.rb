class Room < ActiveRecord::Base
  attr_accessible :label, :audio, :video
  has_many :proposals
end
