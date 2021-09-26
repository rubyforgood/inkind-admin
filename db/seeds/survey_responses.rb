survey = Survey.first

volunteer1, volunteer2 = User.where(role: :volunteer).first(2)

Student.first(3).each do |student|
  survey_response = SurveyResponse.create!(survey: survey, volunteer: volunteer1, student: student)
  SurveyTextQuestion.where(survey: survey).each do |question|
    SurveyQuestionResponse.create!(
      response: survey_response,
      question: question,
      reply: Faker::Lorem.sentence
    )
  end
  SurveySingleSelectQuestion.where(survey: survey).each do |question|
    question_response = SurveyQuestionResponse.create!(
      response: survey_response,
      question: question
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.sample,
      question_response: question_response
    )
  end
  SurveyMultiSelectQuestion.where(survey: survey).each do |question|
    question_response = SurveyQuestionResponse.create!(
      response: survey_response,
      question: question
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.first,
      question_response: question_response
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.second,
      question_response: question_response
    )
  end

  puts "created survey response from #{volunteer1.name} for #{student.name}"
end

Student.last(2).each do |student|
  survey_response = SurveyResponse.create!(survey: survey, volunteer: volunteer2, student: student)
  SurveyTextQuestion.where(survey: survey).each do |question|
    SurveyQuestionResponse.create!(
      response: survey_response,
      question: question,
      reply: Faker::Lorem.sentence
    )
  end
  SurveySingleSelectQuestion.where(survey: survey).each do |question|
    question_response = SurveyQuestionResponse.create!(
      response: survey_response,
      question: question
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.sample,
      question_response: question_response
    )
  end
  SurveyMultiSelectQuestion.where(survey: survey).each do |question|
    question_response = SurveyQuestionResponse.create!(
      response: survey_response,
      question: question
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.third,
      question_response: question_response
    )
    SurveyQuestionOptionResponse.create!(
      option: question.options.fourth,
      question_response: question_response
    )
  end

  puts "created survey response from #{volunteer2.name} for #{student.name}"
end
