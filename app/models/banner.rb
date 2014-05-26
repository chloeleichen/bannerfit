class Banner < ActiveRecord::Base

	validates :name, presence: true 
	validates :content, presence: true,
						length: {minimum: 2 }


	validates :user_id, presence: true 





	belongs_to :user 


	def self.from_users_subscribed_by(user)
    subscribed_user_ids = "SELECT subscribed_id FROM subscriptions
                         WHERE subscriber_id = :user_id"
    where("user_id IN (#{subscribed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end


	# ADD ATTATCHMENT 

	has_attached_file :pic, :styles => { :medium => "300x300>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/

end
