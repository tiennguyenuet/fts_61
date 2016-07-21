class UserMailer < ApplicationMailer
  default from: Settings.default_email

  def notify_user_subject_create user, subject
    @user = user
    @subject = subject
    mail to: @user.email, subject: "#{subject.name}"
  end
end
