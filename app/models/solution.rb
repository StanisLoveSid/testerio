class Solution < ApplicationRecord
  belongs_to :solutionable, polymorphic: true
end
