class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
	default from: 'betasoft111@gmail.com'
 
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def forgot_password(user, link)
  	@user = user
  	@link = link
    mail(to: @user.email, subject: 'Reset your password')
  end

  def payment_email(user, plan)
    @user = user
    @plan = plan
    mail(to: @user.email, subject: 'Reset your password')
  end

end
