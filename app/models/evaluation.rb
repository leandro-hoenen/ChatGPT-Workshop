class Evaluation < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :accuracy, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :accuracy_description, presence: true, length: { minimum: 15, maximum: 120 }
  validates :relevance, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :relevance_description, presence: true, length: { minimum: 15, maximum: 120 }
  validates :bias, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :bias_description, presence: true, length: { minimum: 15, maximum: 120 }
  validates :comments, length: { maximum: 500 }
  validates :task_id, presence: true
  validates :user_id, presence: true
end
