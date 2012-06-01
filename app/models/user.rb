# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible  :name, :email, :password, :password_confirmation, :gravatar
  has_many :soundposts, dependent: :destroy
  has_secure_password
  
  before_save { self.email.downcase! }
  before_save :create_remember_token
  
  validates :name, presence: true, length:  { maximum: 50 }
  REGEX_VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: REGEX_VALID_EMAIL },
      uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def feed
    # TODO: modify for "Following users"
    Soundpost.where("user_id = ?", id)
  end
  
  private
    
    def fmtted
      "#{self.name} <#{self.email.downcase}>"
    end
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
