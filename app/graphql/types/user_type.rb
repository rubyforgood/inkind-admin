module Types
  class UserType < Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: true
    field :email, String, null: true
    field :role, String, null: true
    field :initials, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
