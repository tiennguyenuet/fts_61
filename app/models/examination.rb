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

  private
  def create_question
    self.questions << self.subject.questions.valid_question.shuffle
      .take(self.subject.total_question)
  end
end
