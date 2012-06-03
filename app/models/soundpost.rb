class Soundpost < ActiveRecord::Base

  attr_accessible :content, :filetype, :ext, :MAX_FILESIZE_KB
  validates :user_id, presence: true
  validates :content, presence: true
  validates_size_of :content, :maximum => 50.kilobytes,
      :message => "Maximum file size is 50 kilobytes"
  belongs_to :user
  
  default_scope order: 'soundposts.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
        WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        user_id: user.id)
  end
  

end
