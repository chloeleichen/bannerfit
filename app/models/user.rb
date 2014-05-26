class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #data validation 

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :profile_name, presence: true,
							uniqueness: true,
							format: { with: /\A[a-zA-Z0-9_-]+\z/,
              message: "does not allow white space" }


   #subscriptions with banner 

   has_many :banners

   has_many :subscriptions, :foreign_key => "subscriber_id",
                            :dependent => :destroy

  has_many :subscribeds, through: :subscriptions



  has_many :reverse_subscriptions, :foreign_key => "subscribed_id",
                                   :class_name => "Subscription",
                                   :dependent => :destroy
  has_many :subscribers, :through => :reverse_subscriptions

 	def full_name 

 		first_name + " " +last_name 
 	end 


  def to_param
    profile_name 
  end 


    def subscribing?(other_user)
    subscriptions.find_by(subscribed_id: other_user.id)
  end

  def subscribe!(other_user)
    subscriptions.create!(subscribed_id: other_user.id)
  end

  def unsubscribe!(other_user)
    subscriptions.find_by(subscribed_id: other_user.id).destroy
  end 

  





  # ADD GRAVATAR 

  def gravatar_url 
    processed_email= email.strip.downcase 

    hash = Digest::MD5.hexdigest(processed_email)

    return "http://gravatar.com/avatar/#{hash}"



  end 

         
end
