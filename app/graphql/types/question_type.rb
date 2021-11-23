module Types
  class QuestionType < Base::Object
    field :id, ID, null: false
    field :type, String, null: false
    field :heading, String, null: true
    field :prompt, String, null: false
    field :description, String, null: true
    field :options, [Types::QuestionOptionType], null: true
  end
end
