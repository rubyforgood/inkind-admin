module AuthenticationToken
  extend ActiveSupport::Concern

  def token
    crypt = self.class._encryptor
    crypt.encrypt_and_sign("user-id:#{id}")
  end

  class_methods do
    def by_token(token)
    end

    def id_from_token(token)
      crypt = _encryptor
      actual_token = crypt.decrypt_and_verify token
      actual_token.gsub("user-id:", "").to_i
    end

    def _encryptor
      ActiveSupport::MessageEncryptor.new(
        Rails.application.credentials.secret_key_base.byteslice(0..31)
      )
    end
  end
end
