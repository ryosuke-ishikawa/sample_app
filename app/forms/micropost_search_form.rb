class MicropostSearchForm
  include ActiveModel::Model
 
  attr_accessor  :user_name, :public ,:user_option,:followed_user_id
 
  def search
    rel = Micropost
    rel = rel.joins(:user).where('users.name like ?' , "%#{user_name}%" ).uniq if user_name.present?
    rel = case user_option
            when "default"
                rel
            #検索対象のユーザーをフォローしているユーザーの投稿を検索する    
            when "followed_user"
                follower_user_ids = Relationship.where(followed_id: searched_user_ids).map(&:follower_id).uniq
                Micropost.where(user_id: follower_user_ids)

            
            #検索対象のユーザーの投稿にいいねをしたユーザーの投稿を検索する    
            when "liked_user"
                liked_user_ids = Like.where(micropost_id: searched_user_micropost_ids).map(&:user_id).uniq
                Micropost.joins(:user).where(user_id: liked_user_ids)
            
            #検索対象のユーザーがフォローしているユーザーがいいねした投稿を検索する
            when "follow_like"
                followed_user_ids = Relationship.where(follower_id: searched_user_ids).map(&:follower_id).uniq
                liked_micropost_ids = Like.where(user_id: followed_user_ids).map(&:id).uniq
                Micropost.joins(:user).where(id: liked_micropost_ids)
                
    #            
    
            #検索対象のユーザーがいいねをした投稿のユーザーがいいねをした投稿を検索する
            when "liking_liking"
                liking_micropost_ids = Like.where(user_id: searched_user_ids).map(&:micropost_id)
                liking_user_ids = Micropost.where(id: liking_micropost_ids).map(&:user_id)
                liking_liking_micropost_ids = Like.where(user_id: liking_user_ids).map(&:micropost_id)
                Micropost.joins(:user).where(id: liking_liking_micropost_ids)
    #            rel
            else
                rel
            end
             
    rel = case public
            when 'true'
             rel.where(public: true)
            when 'false'
             rel.where(public: false)
            else
             rel
            end

    
    rel
  end

#  if user_name.present?
#    searched_user_ids = User.where("name LIKE ?", "%#{user_name}%").map(&:id)
#    follower_user_ids = Relationship.where(follower_id: searched_user_ids).map(&:followed_id).uniq
#    #follower_user_ids = Relationship.where(follower_id: followed_user_id).map(&:followed_id).uniq
#    #follower_user_ids = Relationship.where(follower_id: user.id).map { |relationship| relationship.followed_id }
#    where("user_id IN :user_id", user_id: follower_user_ids)
# end
  
  
  def self.from_users_follower_by(user)
#   follower_user_ids = <<-AA
#    SELECT follower_id FROM relationships
#    INNER JOIN users AS followers ON relationships.follower_id = followers.id
#    WHERE followers.name LIKE :user_name
#    AA
#   where("user_id IN (#{follower_user_ids})",user_name: user_name)
    follower_user_ids = Relationship.where(follower_id: user.id).map(&:followed_id)
    #follower_user_ids = Relationship.where(follower_id: user.id).map { |relationship| relationship.followed_id }
    where("user_id IN :user_id", user_id: follower_user_ids)
  end

  def find_by_follower_name
      Micropost.joins(user: { relationships: :follower }).where( "followers_relationships.name LIKE ?", "%#{user_name}%" ).uniq
  end
  
  
  #検索されたユーザーのユーザーidを取得する
  def searched_user_ids 
   User.where('name Like ?', "%#{user_name}%").map(&:id)
  end
  
  #検索されたユーザーの投稿のidを取得する
  def searched_user_micropost_ids
    Micropost.joins(:user).where("users.name Like ?", "%#{user_name}%").map(&:id)
  end
  
end