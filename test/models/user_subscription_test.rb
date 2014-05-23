require 'test_helper'

class UserSubscriptionTest < ActiveSupport::TestCase
# should_belong_to :user

# should_belong_to (:subscribe)

test "that create a subscription works" do 

	assert_nothing_raised do 

	UserSubscription.create user: users(:chloe), subscribe: users(:jeremy)

	end 
end 
test " creating a subscription based on user id and subscribe id works" do 

	UserSubscription.create user_id: users(:chloe).id, subscribe_id: users(:jeremy).id 

	 assert users(:chloe).subscribes.include?(users(:jeremy))

	end 

end
