class UserInvite
  include Interactor

  def call
    user = User.new(context.user_params)
    password = SecureRandom.alphanumeric() + ["!","@","$","%"].sample(1).join
    password = User.password
    user.password = password
    user.password_confirmation = password
    user.status = true
    user.skip_confirmation!
    if user.save   
      UserMailer.with(user: user, password: password).welcome_email.deliver_now
      return true
    end
  end
end
