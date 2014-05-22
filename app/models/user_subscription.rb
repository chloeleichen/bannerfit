class UserSubscription < ActiveRecord::Base

	belongs_to :user
	belongs_to :subscriber, class_name: 'User', foreign_key: 'subscriber_id'




end
