module Types
  class MutationType < Base::Object
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
