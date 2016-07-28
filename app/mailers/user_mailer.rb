class UserMailer < ApplicationMailer
  default from: Settings.default_email

  def notify_user_subject_create user, subject
    @user = user
    @subject = subject
    mail to: @user.email, subject: "#{subject.name}"
  end

  def send_exam_result exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("views.user_mailer.send_result_title")
  end
end
