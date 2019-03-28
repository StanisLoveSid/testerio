class Test < ApplicationRecord
  include AASM

  aasm do
    state :draft, initial: true
    state :production

    event :to_production do
      transitions from: :draft, to: :production
    end
  end

  belongs_to :test_group
  has_many :questions, dependent: :destroy
  has_many :solutions, dependent: :destroy

  def percents(user_score)
    (user_score.to_f / score.to_f * 100.0).round(1)                                                                   
  end
  
  def passed?
    percents > 60.0
  end

  def score
  	questions.map(&:answers).map{|answers| answers.map(&:score).sum}.sum
  end
end
