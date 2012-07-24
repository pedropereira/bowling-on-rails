class Game < ActiveRecord::Base
  attr_accessible :current_frame_number, :finished

  has_many :frames

  after_create :init!

  def init!
    10.times { self.frames << Frame.create }

    self.save
  end

  def current_frame
    frames[current_frame_number - 1]
  end

  def roll!(number_of_pins)
    raise "Game has finished." if finished

    current_frame.roll!(number_of_pins)

    if current_frame_number < 10
      self.current_frame_number += 1 if current_frame.is_strike? or !current_frame.second_roll.nil?
    else
      self.finished = true if (current_frame.is_strike? and !current_frame.third_roll.nil?) or
                              (current_frame.is_spare? and !current_frame.third_roll.nil?) or
                              (!current_frame.is_strike? and !current_frame.is_spare? and !current_frame.second_roll.nil?)
    end

    self.save
  end

  def total_score
    total_score = 0
    frames.each { |frame| total_score += frame.score unless frame.score.nil? }
    total_score
  end
end
