class Examination < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :subject
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  enum status: [:start, :testing, :saved, :unchecked, :checked]

  tracked  owner: ->(controller, model) {controller && controller.current_user}

  after_create :create_question
  after_save :notify_user
  after_update :update_delayed_job

  private
  def create_question
    self.questions << self.subject.questions.valid_question.shuffle
      .take(self.subject.total_question)
  end

  def notify_user
    send_email = SendEmail.new self
    Delayed::Job.enqueue send_email, 1, 80.minutes.from_now
  end

  def update_delayed_job
    time_from_create_exam = self.updated_at - self.created_at
    if time_from_create_exam.to_i < Settings.time_to_notify
      if Delayed::Job.find_by(created_at: self.created_at).present?
        Delayed::Job.find_by(created_at: self.created_at).delete
      end
    end
  end
end
