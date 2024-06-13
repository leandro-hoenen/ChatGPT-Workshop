class Scenario < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
end
