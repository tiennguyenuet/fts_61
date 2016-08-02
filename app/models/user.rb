class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_many :examinations, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum role: [:user, :admin, :supper]
  validates :name, presence: true, length: {maximum: 30},
    uniqueness: {case_sensitive: true}

  class << self
    def from_omniauth access_token
      data = access_token.info
      user = User.where(email: data["email"]).first
      unless user
        user = User.create(name: data["name"],
          email: data["email"]
        )
      end
      user
    end
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
