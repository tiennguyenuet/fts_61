class User < ActiveRecord::Base
  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum role: [:user, :admin]
end
