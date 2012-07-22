class Frame < ActiveRecord::Base
  attr_accessible :first_roll, :pins_left, :score, :second_roll, :third_roll, :mark

  belongs_to :game

  def roll!(number_of_pins)
    if (number_of_pins > pins_left and game.current_frame_number < 10) or number_of_pins < 0 or number_of_pins > 10
      raise "Invalid number of pins."
    elsif first_roll.nil?
      self.first_roll = number_of_pins
    elsif second_roll.nil?
      self.second_roll = number_of_pins
    elsif mark == 'strike' and game.current_frame_number == 10
      second_roll.nil? ? self.second_roll = number_of_pins : self.third_roll = number_of_pins
    end

    self.pins_left -= number_of_pins if pins_left > 0
    update_mark

    self.save
  end

  def update_mark
    if first_roll == 10
      self.mark = 'strike'
    elsif pins_left == 0 and game.current_frame_number < 10
      self.mark = 'spare'
    end
  end
end
