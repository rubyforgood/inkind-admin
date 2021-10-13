module Types
  class QuestionType < Base::Object
    field :id, ID, null: false
    field :type, String, null: false
    field :prompt, String, null: false
    field :options, [Types::QuestionOptionType], null: true
  end
end
