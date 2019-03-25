class TestGroup < ApplicationRecord
  belongs_to :user
  has_many :tests, dependent: :destroy
end
