class SendEmail < Struct.new(:exam)
  def perform
    UserMailer.notify_user_do_exam(exam).deliver_now
  end
end
