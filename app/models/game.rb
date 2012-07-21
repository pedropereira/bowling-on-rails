class Game < ActiveRecord::Base
  attr_accessible :current_frame

  has_many :frames
end
