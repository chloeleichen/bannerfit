require 'test_helper'

class UserSubscriptionTest < ActiveSupport::TestCase
# should_belong_to :user

# should_belong_to (:subscriber)

test "that create a subscription works" do 

	assert_nothing_raised do 

	UserSubscription.create user: users(:chloe), subscriber: users(:jeremy)

	end 
end 
test " creating a subscription based on user id and subscriber id works" do 

	UserSubscription.create user_id: users(:chloe).id, subscriber_id: users(:jeremy).id 

	 assert users(:chloe).subscribers.include?(users(:jeremy))

	end 

end
