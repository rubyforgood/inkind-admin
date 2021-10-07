# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyQuestion, type: :model do
  it 'has valid factory' do
    expect(create(:survey_question)).to be_valid
  end
end
