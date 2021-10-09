module Types
  class MutationType < Types::Base::Object
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
