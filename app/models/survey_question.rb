class SurveyQuestion < ApplicationRecord
  belongs_to :survey

  validates :heading, length: {maximum: 400}
  validates :prompt, presence: true, length: {maximum: 10_000}
  validates :description, length: {maximum: 10_000}
end
