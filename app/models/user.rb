class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name,  presence: true, length: { maximum: 50 }
  
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :liked_micropost, through: :likes, source: :micropost

  
  
  def feed
     Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  
  def already_liked?(micropost)
    likes.exists?(micropost_id: micropost.id)    
  end
  
  #ユーザー名での検索
  scope :get_by_name, -> name {
    where('name like ?', "%#{name}%")
  }
  
  #投稿内容での検索
  scope :get_by_content, -> content{
    joins(:microposts).where('content like ?', "%#{content}%").uniq
  }
  
  #クラスメソッドが上、インスタンスメソッドより上
  #①デバイスは上、ログインが必要であることが定義されている情報なので一番上
  #②validateも上
  #③リレーション
  #④scope
  

    
end
