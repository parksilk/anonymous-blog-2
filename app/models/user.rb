class User < ActiveRecord::Base
  has_secure_password
  
  has_many :posts

  before_save :downcase_email
  before_save :create_remember_token

  validates :username, { presence: true, uniqueness: { case_sensitive: false } }

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def downcase_email
      self.email.downcase!
    end
end
