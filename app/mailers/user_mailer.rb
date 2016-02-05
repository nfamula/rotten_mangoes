class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def delete_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your account has been deleted')
  end
end