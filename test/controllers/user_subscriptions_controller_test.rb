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


test "assign a new user_subscrption" do 
  sign_in users(:chloe)
  get :new, subscribe_id:users(:jeremy)
  assert_equal users(:jeremy), assigns(:user_subscription).subscribe
  end 


  test "user is current user" do 

    sign_in users(:chloe)
  get :new, subscribe_id:users(:jeremy)
  assert_equal users(:chloe), assigns(:user_subscription).user
end 

  test "return 404 if no friend found " do 

    sign_in users(:chloe)
    get :new, subscribe_id: "invalid"
    assert_response :not_found 
  end 


  test "cannot subscribe, redirect to login page when not logged in" do 
    get :new 
    assert_response :redirect 
    assert_redirected_to login_path 
  end 



  test"logged in and subscribe without subscribe id" do 
   sign_in users(:chloe)
   post :create 

   assert !flash[:error].empty?
   assert_response :redirect
   assert_redirected_to root_path
 end 


  test"logged in and subscribe with subscribe id" do 
   sign_in users(:chloe)
   post :create, subscribe_id: users(:jeremy)

   assert assigns(:subscribe)


   assert_response :success
   assert assigns(:user_subscription)

   assert_equal users(:jeremy), assigns(:subscribe)
   assert_equal users(:chloe), assigns(:user_subscription).user 
   assert_equal users(:jeremy), assigns(:user_subscription).subscribe 

   assert users(:chloe).subscribes.include?(users(:jeremy))

   
 end 

 test "flash message confirming subscriptions" do 

  sign_in users(:chloe)
   post :create, subscribe_id: users(:jeremy)
  assert flash[:success]
  assert_equal "you have subscribed #{users(:jeremy).profile_name}", flash[:success]
  

 end 











# end 

# test "beed subscribe_id to subscribe"

# end 

end