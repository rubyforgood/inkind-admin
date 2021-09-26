module AuthenticationHelpers
  # session based sign in
  def sign_in(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
      { token: user.token }
    }
  end

  # header based authentication
  def authentication_header(user)
    { "Authorization" => "Bearer #{user.token}" }
  end
end

RSpec.configure { |config| config.include AuthenticationHelpers }
