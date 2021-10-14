# Preview all emails at http://localhost:3000/rails/mailers/magic_link
class MagicLinkPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/magic_link/sign_in
  def sign_in
    MagicLinkMailer.sign_in
  end

end
