require 'test_helper'

class SubscribeAUserTest < ActionDispatch::IntegrationTest

def sign_in_as(user, password)
	post login_path, user:{email: user.email , password: password}
end 

 test "subscribe a user works" do 

 	sign_in_as users(:chloe), "password"

 	get "/user_subscriptions/new?friend_id=#{users(:jeremy).profile_name}"
 	assert_response :success 

 	assert_difference 'UserSubscription.count' do 
 		post "/user_subscriptions", user_subscription: {subscribe_id: users(:jeremy).profile_name}
		assert_equal "you have subscribed #{users(:jeremy).profile_name}", flash[:success]

 	end 
 end 



end
