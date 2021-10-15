module Types
  class MutationType < Base::Object
    field :sign_in_user, mutation: Mutations::SignInUser
    field :update_user, mutation: Mutations::UpdateUser
    field :update_user_password, mutation: Mutations::UpdateUserPassword
  end
end
