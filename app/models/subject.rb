class Subject < ActiveRecord::Base
  has_many :examinations, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true, length: {maximum: 150}
  validates :total_question, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validates :duration, presence: true,
    numericality: {only_integer: true, greater_than: 0}

  after_create :notify_user

  def notify_user
    UserNotification.new(self).send_notify_user
  end
end
