require 'test_helper'

class UserSubscriptionsControllerTest < ActionController::TestCase

	# setup do 

	# 	sign_in users(:chloe)
  		
 #  	end 



  test "redirect to login when subscribe without login " do 
  	get :new 

  	assert_response :redirect 
  end 


  test "when logged in can subscribe " do


  	sign_in users(:chloe)
  	
  	get :new
  	assert_response :success 
  end 

test "should show flash when subsriber_id is missing" do 
  sign_in users(:chloe)
	get :new, {}


	assert_equal "subscribe required", flash[:error]


end 

# test "display subscribe's name" do 

#   get :new, subscribe_id: users(:jeremy).id 
#   assert_match /#{users(:jeremy).profile_name}/



# end 

# test "beed subscribe_id to subscribe"

# end 

end