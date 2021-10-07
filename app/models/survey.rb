# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :questions, class_name: 'SurveyQuestion', dependent: :destroy

  validates :name, presence: true
end
