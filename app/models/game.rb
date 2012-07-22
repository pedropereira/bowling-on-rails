class Game < ActiveRecord::Base
  attr_accessible :current_frame

  has_many :frames

  after_create :init

  def init
    10.times do
      self.frames << Frame.create
    end
  end

  def total_score?
    total_score = 0

    frames.each do |frame|
      total_score = total_score + frame.score
    end

    total_score
  end
end
