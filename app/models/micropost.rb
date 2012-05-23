class Micropost < ActiveRecord::Base
  attr_accessible :clip, :user_id
  belongs_to :user
end
