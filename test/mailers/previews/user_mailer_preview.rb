# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_letter
  def welcome_letter
    user = User.first
    UserMailer.welcome_letter(user)
  end

end
