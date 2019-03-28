class TestGroup < ApplicationRecord
  #scope :current_tests, -> (id) { includes(:tests).where(["id > ?", id])}

  belongs_to :user
  belongs_to :subject
  has_many :tests, dependent: :destroy
end
