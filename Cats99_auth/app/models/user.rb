class User < ApplicationRecord
  validates :password, presence: true, length: { minimum: 6, allow_nil: true }
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  after_initialize :ensure_session_token

attr_reader :password

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    if @user && @user.is_password?(password)
      @user
    else
      nil
    end
    
  end

  def password=(password)
    @password = password
    self.password_digest = Bcrypt::Password.create(password)
    
  end


  def is_password?(password)
    #compares digests
    Bcrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64 #POTENTIAL ERROR, possibly colon instaed of period
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64 #Potential problem, double colon not period
    self.save!
    self.session_token
  end

end
