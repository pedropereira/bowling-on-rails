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

    if !current_frame.second_roll.nil? and current_frame_number < 10
      self.current_frame_number += 1
    elsif !current_frame.second_roll.nil? and current_frame_number == 10 and current_frame.mark != 'strike'
      self.finished = true
    elsif current_frame.mark == 'strike' and current_frame_number < 10
      self.current_frame_number += 1
    elsif current_frame.mark == 'strike' and current_frame_number == 10 and !current_frame.third_roll.nil?
      self.finished = true
    end

    self.save
  end

  def total_score
    total_score = 0
    frames.each { |frame| total_score += frame.score unless frame.score.nil? }
    total_score
  end
end
