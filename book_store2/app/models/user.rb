class User < ApplicationRecord
  attr_writer :login
  before_create :set_username
    # validates_length_of :username,
    # :within => 5..50,
    # :too_short => 'too short username, min 5 characters',
    # :too_long => 'too long username, max 50 characters',
    # :presence => true
  validate :validate_username
  has_many :books
  has_many :comments, through: :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  def login
    @login || self.username || self.email
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  private
    def set_username
      self.username = self.email.split("@").first
    end  
end
