module Mutations
  class SignInUser < Base::Mutation
    argument :credentials, Inputs::AuthProviderCredentialsInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      user = User.find_by email: credentials[:email]

      # ensures we have the correct user
      raise GraphQL::ExecutionError, "user with email does not exist" unless user

      raise GraphQL::ExecutionError, "account associated with email is no longer active" if user.inactive?

      raise GraphQL::ExecutionError, "invalid password for user" unless user.valid_password?(credentials[:password])

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      token = user.token

      context[:session][:token] = token

      {user: user, token: token}
    end
  end
end
