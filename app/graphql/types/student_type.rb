module Types
  class StudentType < Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: true
    field :nickname, String, null: true
    field :date_of_birth, GraphQL::Types::ISO8601DateTime, null: true
    field :initials, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :guardian_first_name, String, null: true
    field :guardian_last_name, String, null: true
    field :guardian_name, String, null: true
    def guardian_name
      # object.guardian_full_name
      # binding.pry
    end
    field :guardian_phone_number, String, null: true
    field :emergency_contact_first_name, String, null: true
    field :emergency_contact_last_name, String, null: true
    field :emergency_contact_name, String, null: true
    def emergency_contact_name
      # object.emergency_contact_full_name
    end
    field :emergency_contact_phone_number, String, null: true
  end
end
