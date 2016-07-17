class UserNotification
  def initialize subject
    @subject = subject
  end

  def send_notify_user
    @users = User.all
    @users.each do |user|
      UserMailer.notify_user_subject_create(user, @subject).deliver_now
    end
  end
end
