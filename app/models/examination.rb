class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  enum status: [:start, :testing, :saved, :unchecked, :checked]

  after_create :create_question

  private

  def create_question
    self.questions << self.subject.questions.order("RANDOM()")
      .limit(self.subject.total_question)

  end
end
