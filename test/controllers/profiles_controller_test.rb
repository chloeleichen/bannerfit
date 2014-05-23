require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:chloe).profile_name
    assert_response :success

    # assert_template 'profile/show'
  end



  test "should redirect to 404 if not found" do 

  	get :show, id: "invalid"

  	assert_response :not_found 



  end 

  test "variables assigned sucessfully" do 

  	get :show, id: users(:chloe).profile_name

  	assert assigns(:user)

  	assert_not_empty assigns(:banners)
    

    assert_response :success



  end 


  test "should only show own banners on profile page" do 


  get :show, id: users(:jeremy).profile_name

  assigns(:banners).each do |banner|

  	puts banner.user 

  	assert_equal users(:jeremy), banner.user 
  end 



end 




end
