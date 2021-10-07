# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyQuestionOptionResponse, type: :model do
  it 'has valid factory' do
    expect(create(:survey_question_option_response)).to be_valid
  end
end
