class Examination < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :subject
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results,
    reject_if: lambda{|att| att[:question_id].blank?}, allow_destroy: true

  enum status: [:start, :testing, :unchecked, :checked]

  tracked  owner: ->(controller, model) {controller && controller.current_user}

  before_create :create_questions

  private
  def create_questions
    total_question = subject.questions.size
    questions = subject.questions.order("RANDOM()")
    if Settings.number_question1 == total_question
      duration = Settings.duration1
    else
      duration = Settings.duration2
    end
  end
end
