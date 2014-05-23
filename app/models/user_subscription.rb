class UserSubscription < ActiveRecord::Base

	belongs_to :user
	belongs_to :subscribe, class_name: 'User', foreign_key: 'subscribe_id'




end
