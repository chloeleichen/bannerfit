class Subscription < ActiveRecord::Base

  belongs_to :subscriber, :class_name => "User"
  belongs_to :subscribed, :class_name => "User"

  validates :subscriber_id, :presence => true
  validates :subscribed_id, :presence => true


  def following?(other_user)
    subscriptions.find_by(subscribed_id: other_user.id)
  end

  def follow!(other_user)
    subscriptions.create!(subscribed_id: other_user.id)
  end

  def unfollow!(other_user)
    subscriptions.find_by(subscribed_id: other_user.id).destroy
end 


end

