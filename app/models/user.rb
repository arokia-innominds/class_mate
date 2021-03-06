class User < ActiveRecord::Base
  
  attr_accessor :password, :password_confirmation
  validates :password, :email, presence: true
  validates :password , length: { in: 6..20 }

  belongs_to :class_room
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user &&  user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
