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


   #relationships with banner 

   has_many :banners
   has_many :user_subscriptions
   has_many :subscribes, through: :user_subscriptions

 	def full_name 

 		first_name + " " +last_name 
 	end 



  # ADD GRAVATAR 

  def gravatar_url 
    processed_email= email.strip.downcase 

    hash = Digest::MD5.hexdigest(processed_email)

    return "http://gravatar.com/avatar/#{hash}"



  end 

         
end
