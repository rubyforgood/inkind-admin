module AuthenticationStrategies
  class UserToken < Warden::Strategies::Base
    def store?
      false
    end

    def valid?
      bearer_token.present?
    end

    def authenticate!
      success! User.by_token(bearer_token)
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      fail! "Invalid token value"
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      fail! "Invalid token signature"
    end

    def bearer_token
      @bearer_token ||= request.headers["Authorization"]
                               &.match(/^Bearer (.*)/)
                               &.captures&.at(0)
    end
  end
end
