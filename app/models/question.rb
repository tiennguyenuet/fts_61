class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  enum state: [:waitting, :accepted, :reject]

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  enum question_type: [:single, :multiple, :text]

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, presence: true, length: {minimum: 2}
  validates_associated  :answers
  validate :validate_answers

  scope :valid_question, -> do
    where("state IS NOT 2")
  end

  def validate_answers
    unless self.text?
      if answers.size <= 1
        errors.add(:answer, I18n.t("controllers.admin.question.validate_number_answer"))
      end
      if answers.reject{|answer| !answer.is_correct?}.count == 0
        errors.add(:correct_answers, I18n.t("controllers.admin.question.number_correct"))
      end
    end
  end
end
