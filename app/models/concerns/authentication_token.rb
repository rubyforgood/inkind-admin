module AuthenticationToken
  extend ActiveSupport::Concern

  def token
    self.class.create_token(self)
  end

  class_methods do
    def create_token(user)
      _encryptor.encrypt_and_sign(user.id, purpose: :authn)
    end

    def by_token(token)
      find(_encryptor.decrypt_and_verify(token.to_s, purpose: :authn))
    end

    def _encryptor
      ActiveSupport::MessageEncryptor.new(
        # TODO: retest this in dev env
        Rails.application.secret_key_base.byteslice(0..31)
      )
    end
  end
end
