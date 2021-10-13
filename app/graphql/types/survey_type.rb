module Types
  class SurveyType < Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :questions, [Types::QuestionType], null: true
  end
end
