class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  ### relationship
  has_many :boards, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :sr_events, dependent: :destroy

  ############# For devise
  # override devise's find_first_by_auth_conditions to let user login by either username or email
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  # google authentication.
  def self.find_or_create_user_for_google(data)
    user = self.find_by(email: data[:email])
    return user if user
    self.create!(email:         data[:email],
                 username:      data[:name],
                 provider:      "google_oauth2",
                 uid:           data[:email],
                 refresh_token: self.generate_unique_secure_token,
                 password:      Devise.friendly_token[0, 20],
                 confirmed_at:  Time.now)
  end
end
