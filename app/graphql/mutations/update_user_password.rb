module Mutations
  class UpdateUserPassword < Base::Mutation
    argument :old_password, String, required: true
    argument :password, String, required: true

    type Boolean

    def resolve(old_password:, password:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Old password does not match" unless user.valid_password?(old_password)

      user.update!(password: password)
    rescue ActiveRecord::RecordInvalid => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
