class Subject < ApplicationRecord
  belongs_to :user
  has_many :test_groups
end
