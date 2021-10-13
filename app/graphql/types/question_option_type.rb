module Types
  class QuestionOptionType < Base::Object
    field :id, ID, null: false
    field :label, String, null: false
  end
end
