class TestGroup < ApplicationRecord
  #scope :current_tests, -> (id) { includes(:tests).where(["id > ?", id])}

  belongs_to :user
  belongs_to :subject
  has_many :tests, dependent: :destroy

  def score
    tests.map(&:score).sum
  end

  def percents(user_score)
    (user_score.to_f / score.to_f * 100.0).round(1)
  end

  def passed?(percents)
    percents > 60.0
  end
end
