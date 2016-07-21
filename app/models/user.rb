class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:digitalocean]

  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum role: [:user, :admin]

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: true}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
