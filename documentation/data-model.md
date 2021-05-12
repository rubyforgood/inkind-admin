BACKEND

Student
- full name
- email address
- location
- birthdate
- nickname
- archived_at

Volunteer / Admin
- (devise user)
- role
- phone number
- preferred contact
- archived_at

StudentsVolunteer
belongs_to :student
belongs_to :volunteer

Meeting (an instance of a volunteer meeting with a student)
belongs_to :volunteer
belongs_to :student
belongs_to :survey (denormalized)
has_many :responses
- length_in_minutes
- met_at

Survey
has_many :questions_surveys
has_many :questions, through: :questions_surveys
- title
- archived_at

Question
- response_type: [ multiple-option-pick-one, multiple-option-pick-many, text ]
- has_optional
- responder_type [ Student, Volunteer ]
- is_required
- archived_at

QuestionOption (Answer)
belongs_to :question
- position

QuestionsSurvey
belongs_to :survey
belongs_to :question
has_many :responses
- position

Response (one answer to one question on one survey)
belongs_to :meeting_id
belongs_to :questions_survey
- is_blank
- response_text

=====

select count(1), response_text from responses where question_id = ? group by response_text


I want to get all question answers for this survey.

example questions

[multiple choice radio]
How do you feel about _______?
 () :(
  () :|
  () :)
  () other: _____________

[multiple choice checkbox]
How do you get to _______?
  [] car
  [] bus
  [] walk
  [] other: _____________

[text]
What is a thing?  _______

[numerical range]
Rate this thing: [  1   2   3   4   5   6   7  ]

[rating]
How cool is this?
* * * * -




