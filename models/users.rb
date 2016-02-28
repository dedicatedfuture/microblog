class User < ActiveRecord::Base
  has_many :posts

  def get_followers


    followersArray = []
    follower_ids = Follower.where(following: self.id).pluck(:followed)

    follower_ids.each do |id|
       followersArray.push(User.where(id).username)
    end




    return followersArray

  end
end
