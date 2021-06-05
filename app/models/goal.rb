class Goal < ApplicationRecord
  validates :milestone, presence: true
  validates :description, presence: true
  belongs_to :user
end
