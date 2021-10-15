module Mutations
  class UpdateUser < Base::Mutation
    argument :data, Inputs::UpdateUserInput, required: true

    type Types::UserType

    def resolve(data:)
      user = context[:current_user]
      user.update!(data.to_h)
      user
    end
  end
end
