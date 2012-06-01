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
  attr_accessible  :name, :email, :password, :password_confirmation
  has_many :soundposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
      class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  
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
    Soundpost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
    
    def fmtted
      "#{self.name} <#{self.email.downcase}>"
    end
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
