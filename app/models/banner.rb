class Banner < ActiveRecord::Base

	validates :name, presence: true 
	validates :content, presence: true,
						length: {minimum: 2 }


	validates :user_id, presence: true 





	belongs_to :user 


	# ADD ATTATCHMENT 

	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/

end
