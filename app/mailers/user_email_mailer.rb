class UserEmailMailer < ApplicationMailer
  default from: 'raoahmar87@gmail.com'

  def notify_friend(user)
    @user = user
    mail(to: 'raoahmar87@gmail.com', subject: "welcome to my self")
  end
end
class UserEmailMailer < ApplicationMailer
end
