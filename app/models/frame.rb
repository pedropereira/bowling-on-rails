class Frame < ActiveRecord::Base
  attr_accessible :first_roll, :pins_left, :score, :second_roll, :third_roll, :mark

  belongs_to :game

  def roll!(number_of_pins)
    if number_of_pins > pins_left or number_of_pins < 0 or number_of_pins > 10
      raise "Invalid number of pins."
    elsif first_roll.nil?
      self.first_roll = number_of_pins
    elsif second_roll.nil?
      self.second_roll = number_of_pins
    elsif is_strike? and game.current_frame_number == 10
      second_roll.nil? ? self.second_roll = number_of_pins : self.third_roll = number_of_pins
    end

    self.pins_left -= number_of_pins if first_roll != 10
    set_mark
    set_score(number_of_pins)

    self.save
  end

  # returns a relative frame to the current one
  def get_frame(shift)
    game.frames[game.current_frame_number - 1 + shift]
  end

  # increments a frame's score
  def add_to_score(score)
    self.score += score
    self.save
  end

  def set_score(number_of_pins)
    self.add_to_score(number_of_pins)

    if game.current_frame_number < 10
      if get_frame(-1).is_strike? and get_frame(-2).is_strike? and (is_strike? or second_roll.nil?)
        get_frame(-2).add_to_score(number_of_pins)
        get_frame(-1).add_to_score(number_of_pins)
      elsif get_frame(-1).is_strike? or (get_frame(-1).is_spare? and second_roll.nil?)
        get_frame(-1).add_to_score(number_of_pins)
      end
    elsif
      if get_frame(-1).is_strike? and get_frame(-2).is_strike?
        get_frame(-2).add_to_score(number_of_pins) if second_roll.nil?
        get_frame(-1).add_to_score(number_of_pins) if third_roll.nil?
      elsif get_frame(-1).is_strike? and (second_roll.nil? or third_roll.nil?)
        get_frame(-1).add_to_score(number_of_pins)
      elsif get_frame(-1).is_spare? and second_roll.nil?
        get_frame(-1).add_to_score(number_of_pins)
      end
    end
  end

  def is_strike?
    self.mark == 'strike'
  end

  def is_spare?
    self.mark == 'spare'
  end

  def set_mark
    self.mark = 'strike' if first_roll == 10
    self.mark = 'spare'  if first_roll != 10 and pins_left == 0
  end
end
