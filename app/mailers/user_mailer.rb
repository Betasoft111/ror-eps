class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
	default from: 'betasoft111@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/log_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
