class SendResultWorker
  include Sidekiq::Worker

  def perform exam_id
    exam = Examination.find exam_id
    UserMailer.send_exam_result(exam).deliver_now
  end
end
