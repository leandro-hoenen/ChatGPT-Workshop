class Task < ApplicationRecord
  belongs_to :scenario

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :scenario_id }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :scenario_id, presence: true
end
