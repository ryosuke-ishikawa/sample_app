class Micropost < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
 
  validates :content,presence:true,length:{maximum: 140}
  validates :user_id,presence:true  
  validates :picture, file_size: {maximum: 1.megabytes.to_i} #最大10Mbに制限
   
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user 
  belongs_to :user 

  default_scope -> {order('created_at DESC')}
  scope :viewable, -> (user) { where("microposts.user_id = :user_id OR microposts.public = t", user_id: user.id) }

 
  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end
     
  def public_for(micropost)
   micropost.update(public: true)
  end
    
  def self.from_users_followed_by(user)
     followed_user_ids = <<-AA
      SELECT followed_id FROM relationships
      WHERE follower_id = :user_id
      AA
     where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
           user_id: user.id)
  end
end
   
