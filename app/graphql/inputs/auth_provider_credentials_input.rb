module Inputs
  class AuthProviderCredentialsInput < Types::Base::InputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
