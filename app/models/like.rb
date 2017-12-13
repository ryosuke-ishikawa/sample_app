class Like < ActiveRecord::Base
    belongs_to :micropost, counter_cache: :likes_count
    belongs_to :user
    
    validates_uniqueness_of :user_id, scope: :micropost_id
end
