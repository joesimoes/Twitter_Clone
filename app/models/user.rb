require 'digest/md5'

class User < ActiveRecord::Base
  attr_accessible :avatar_url, :bio, :email, :name, :password, :password_confirmation, :username
  has_secure_password
 

  has_many :ribbits
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, through: :follower_relationships
  has_many :followeds, through: :followed_relationships

  
  before_validation :prep_email
  before_save :create_avatar_url
    

  validates :email, presence: true, uniqueness: true, format:{ with: /^[\w\.+-]+@([\w]+\.)+[a-zA-Z]/ }
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  def following? user
    self.followeds.include? user
  end
  
  def follow user
    Relationship.create follower_id: self.id, followed_id: user.id
  end

  private
  
  def prep_email
    self.email = self.email.strip.downcase if self.email
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end
end
