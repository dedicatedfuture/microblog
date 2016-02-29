class User < ActiveRecord::Base
  has_many :posts

  def get_followers

    followersArray = []
    follower_ids = Follower.where(following: self.id).pluck(:followed)

    follower_ids.each do |i|
       followersArray.push(User.where(id: i).first.username)
    end

    return followersArray

  end

  def get_following

    followingArray = []
    following_ids = Follower.where(followed: self.id).pluck(:following)

    following_ids.each do |i|
      followingArray.push(User.where(id: i).first.username)
    end

    return followingArray
  end

end
