require 'test_helper'

class BannersControllerTest < ActionController::TestCase
  setup do
    @banner = banners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banners)
  end

  test "should ask user login before new" do
    get :new
    assert_response :redirect 
    assert_redirected_to new_user_session_path 
  end


  test "should be logged in to post banner" do 
    post :create, banner: {content: "hello", name: "message"}
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


  # TO DO: RETEST 


   test "should be logged in to edit" do 
    get :edit, id: @banner
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


   test "should be logged in to update" do 
    get :update, id: @banner
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 


   test "should be logged in to delete" do 
    get :destroy, id: @banner
    assert_response :redirect
    assert_redirected_to new_user_session_path 


  end 

  # test "should create banner when logged in " do

  # assert_difference('Banner.count') do
  #     post :create, banner: { content: @banner.content, name: @banner.name }
  #   end

  #   assert_redirected_to banner_path(assigns(:banner))
  # end



  test "should show banner" do
    get :show, id: @banner
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @banner
  #   assert_response :success
  # end

  # test "should update banner" do
  #   patch :update, id: @banner, banner: { content: @banner.content, name: @banner.name }
  #   assert_redirected_to banner_path(assigns(:banner))
  # end

  # test "should destroy banner" do
  #   assert_difference('banner.count', -1) do
  #     delete :destroy, id: @banner
  #   end

    # assert_redirected_to banners_path
  # end
end
