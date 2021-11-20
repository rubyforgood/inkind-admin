Survey.destroy_all

survey = Survey.create!(name: "Student Session", creator: User.find_by(role: :admin), status: 1)

question1 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  heading: "Question for your student:",
  prompt: "Was today's session helpful?",
  description: "Ask your student this question immediately after the session. " \
               "If your student is not available, please select SKIP."
)
SurveyQuestionOption.create!(question: question1, label: "Yes")
SurveyQuestionOption.create!(question: question1, label: "No")

question2 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  heading: "Question for your student:",
  prompt: "How do you feel about what you learned today?",
  description: "Ask your student this question immediately after the session. " \
               "If your student is not available, please select SKIP."
)
SurveyQuestionOption.create!(question: question2, label: "Sad")
SurveyQuestionOption.create!(question: question2, label: "Slightly sad")
SurveyQuestionOption.create!(question: question2, label: "Neutral")
SurveyQuestionOption.create!(question: question2, label: "Happy")
SurveyQuestionOption.create!(question: question2, label: "Very happy")

question3 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  heading: "Question for you:",
  prompt: "Do you feel like your session today was productive?"
)
SurveyQuestionOption.create!(question: question3, label: "Yes")
SurveyQuestionOption.create!(question: question3, label: "No")

question4 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveyMultiSelectQuestion",
  heading: "Question for you:",
  prompt: "How did your student engage in the session?",
  description: "Check all answers that apply."
)
SurveyQuestionOption.create!(question: question4, label: "Student was attentive")
SurveyQuestionOption.create!(question: question4, label: "Student was engaged")
SurveyQuestionOption.create!(question: question4, label: "Student responded to questions")
SurveyQuestionOption.create!(question: question4, label: "Student had completed homework")
SurveyQuestionOption.create!(question: question4, label: "Student was not engaged")

SurveyQuestion.create!(
  survey: survey,
  type: "SurveyTextQuestion",
  heading: "Question for you:",
  prompt: "Describe your student's progress in a few words."
)

question6 = SurveyQuestion.create!(
  survey: survey,
  type: "SurveySingleSelectQuestion",
  heading: "Question for your:",
  prompt: "Would you like a staff member to contact you?"
)
SurveyQuestionOption.create!(question: question6, label: "Yes")
SurveyQuestionOption.create!(question: question6, label: "No")

puts "Created survey: #{survey.name} with questions"
