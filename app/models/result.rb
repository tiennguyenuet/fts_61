class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :examination
  belongs_to :answer

  scope :is_corrects, -> do
    joins(:answer).where answers: {is_correct: true}
  end
end
