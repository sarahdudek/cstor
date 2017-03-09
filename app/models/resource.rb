class Resource < ActiveRecord::Base
  has_many :likes
  belongs_to :teacher, class_name: "User"
  has_many :likers, through: :likes
  has_many :resource_tags
  has_many :tags, through: :resource_tags

  def like_by_user(user)
    self.likes.find_by(liker_id: user.id)
  end

end
