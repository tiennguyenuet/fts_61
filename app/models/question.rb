class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  enum state: [:waitting, :accepted, :reject]

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  enum question_type: [:single, :multiple, :text]

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answer| answer[:content].blank?}

  scope :suggest, ->{where.not(user_id: nil).where(state: 0)}
  scope :accepted_question, ->{where(state: 1)}
  scope :accepted, -> {where state: 0}

  validates :content, presence: true
end
