class Test < ApplicationRecord
  include AASM

  aasm do
    state :draft, initial: true
    state :production

    event :to_production do
      transitions from: :draft, to: :production
    end
  end

  has_many :questions, dependent: :destroy
  has_many :solutions, dependent: :destroy
end
