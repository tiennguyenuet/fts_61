class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  enum question_type: [:single, :multiple, :text]

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answer| answer[:content].blank?}

  validates :content, presence: true
end
