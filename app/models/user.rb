class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :microposts
  
  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

end
