class MagicLinkMailer < ApplicationMailer
  # Email with an app URL to automatically sign the user in
  #
  def sign_in(user)
    @magic_link = user.token

    mail to: user.email
  end
end
