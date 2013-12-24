class Room < ActiveRecord::Base
  attr_accessible :label, :audio, :video
end
