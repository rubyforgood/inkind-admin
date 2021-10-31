Survey.destroy_all

survey = Survey.create!(name: "Student Session", creator: User.find_by(role: :admin), status: 1)

question1 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  prompt: "Student Question: How did you feel about your session today?"
)
SurveyQuestionOption.create!(question: question1, label: "sad")
SurveyQuestionOption.create!(question: question1, label: "slightly sad")
SurveyQuestionOption.create!(question: question1, label: "neutral")
SurveyQuestionOption.create!(question: question1, label: "happy")
SurveyQuestionOption.create!(question: question1, label: "very happy")

question2 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  prompt: "Do you feel like your session today was productive?"
)
SurveyQuestionOption.create!(question: question2, label: "yes")
SurveyQuestionOption.create!(question: question2, label: "no")

question3 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveyMultiSelectQuestion",
  prompt: "How did your student engage in the session?"
)
SurveyQuestionOption.create!(question: question3, label: "Student was attentive")
SurveyQuestionOption.create!(question: question3, label: "Student was engaged")
SurveyQuestionOption.create!(question: question3, label: "Student responded to questions")
SurveyQuestionOption.create!(question: question3, label: "Student had completed homework")
SurveyQuestionOption.create!(question: question3, label: "Student was not engaged")

SurveyQuestion.create!(
  survey: survey,
  type: "SurveyTextQuestion",
  prompt: "Describe your student's progress."
)

puts "Created survey: #{survey.name} with questions"
