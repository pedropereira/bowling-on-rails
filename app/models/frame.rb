class Frame < ActiveRecord::Base
  attr_accessible :first_roll, :pins_left, :score, :second_roll, :third_roll, :mark

  belongs_to :game
end