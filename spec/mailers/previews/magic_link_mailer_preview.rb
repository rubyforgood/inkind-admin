class MagicLinkMailerPreview < ActionMailer::Preview
  def sign_in
    MagicLinkMailer.sign_in(User.first)
  end
end
